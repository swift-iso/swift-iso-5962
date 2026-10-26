extension ISO_5962.Expression {
    public init(_ text: String) throws(ISO_5962.Expression.Error) {
        var parser = ISO_5962.Expression.Parser(text)
        self = try parser.expression()
    }
}
