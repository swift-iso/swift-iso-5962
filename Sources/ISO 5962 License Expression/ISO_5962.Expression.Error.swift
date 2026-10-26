extension ISO_5962.Expression {
    public enum Error: Swift::Error, Sendable, Equatable {
        case incomplete
        case unexpected(String)
        case invalid(String)
    }
}
