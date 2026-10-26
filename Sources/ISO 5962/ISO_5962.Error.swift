extension ISO_5962 {
    public enum Error: Swift::Error, Sendable, Equatable {
        case malformed
        case missing(String)
        case invalid(String)
        case unexpected(String)
        case duplicate(String)
    }
}
