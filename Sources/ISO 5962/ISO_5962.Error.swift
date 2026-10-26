public import ISO_5962_License_Expression

extension ISO_5962 {
    public enum Error: Swift::Error, Sendable, Equatable {
        case malformed
        case missing(String)
        case invalid(String)
        case unexpected(String)
        case duplicate(String)
    }
}
