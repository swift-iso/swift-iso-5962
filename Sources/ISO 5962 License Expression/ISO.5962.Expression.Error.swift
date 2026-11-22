extension ISO.`5962`.Expression {
    public enum Error: Swift::Error, Sendable, Equatable {
        case incomplete
        case unexpected(String)
        case invalid(String)
    }
}
