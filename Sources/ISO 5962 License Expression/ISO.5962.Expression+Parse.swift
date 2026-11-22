extension ISO.`5962`.Expression {
    public init(_ text: String) throws(ISO.`5962`.Expression.Error) {
        var parser = ISO.`5962`.Expression.Parser(text)
        self = try parser.expression()
    }
}
