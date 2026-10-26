extension ISO_5962.Expression {
    struct Parser {
        var tokens: ArraySlice<Substring>

        init(_ text: String) {
            self.tokens = ArraySlice(Self.tokens(text))
        }
    }
}
