public import ISO_5962_License_Expression

extension ISO_5962.Package {
    public enum Analysis: Sendable, Hashable {
        case analyzed(ISO_5962.Package.Verification?)
        case unanalyzed
    }
}
