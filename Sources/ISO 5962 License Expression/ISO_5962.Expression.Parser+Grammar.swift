extension ISO_5962.Expression.Parser {
    static func tokens(_ text: String) -> [Substring] {
        var tokens: [Substring] = []
        var start: String.Index?
        for index in text.indices {
            let character = text[index]
            guard character == "(" || character == ")" || character.isWhitespace else {
                if start == nil { start = index }
                continue
            }
            if let open = start { tokens.append(text[open..<index]) }
            start = nil
            if !character.isWhitespace { tokens.append(text[index...index]) }
        }
        if let open = start { tokens.append(text[open...]) }
        return tokens
    }

    mutating func expression() throws(ISO_5962.Expression.Error) -> ISO_5962.Expression {
        let expression = try disjunction()
        if let token = tokens.first { throw .unexpected(String(token)) }
        return expression
    }

    mutating func disjunction() throws(ISO_5962.Expression.Error) -> ISO_5962.Expression {
        var expression = try conjunction()
        while tokens.first == "OR" {
            tokens.removeFirst()
            expression = .disjunction(expression, try conjunction())
        }
        return expression
    }

    mutating func conjunction() throws(ISO_5962.Expression.Error) -> ISO_5962.Expression {
        var expression = try term()
        while tokens.first == "AND" {
            tokens.removeFirst()
            expression = .conjunction(expression, try term())
        }
        return expression
    }

    mutating func term() throws(ISO_5962.Expression.Error) -> ISO_5962.Expression {
        guard let token = tokens.popFirst() else { throw .incomplete }
        switch token {
        case "(":
            let expression = try disjunction()
            guard let close = tokens.popFirst() else { throw .incomplete }
            guard close == ")" else { throw .unexpected(String(close)) }
            return expression
        case ")", "AND", "OR", "WITH":
            throw .unexpected(String(token))
        default:
            let simple = try ISO_5962.Expression.Simple(token)
            guard tokens.first == "WITH" else { return .simple(simple) }
            tokens.removeFirst()
            guard let exception = tokens.popFirst() else { throw .incomplete }
            guard ISO_5962.isIdstring(exception) else { throw .invalid(String(exception)) }
            return .exception(simple, String(exception))
        }
    }
}
