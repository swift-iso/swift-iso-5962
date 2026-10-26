public import ISO_5962_License_Expression

extension ISO_5962.Annotation {
    public enum Kind: String, Sendable, Hashable, CaseIterable {
        case other = "OTHER"
        case review = "REVIEW"
    }
}
