public import ISO_5962_License_Expression

extension ISO.`5962`.Package.Reference {
    public enum Category: String, Sendable, Hashable, CaseIterable {
        case other = "OTHER"
        case security = "SECURITY"
        case packageManager = "PACKAGE_MANAGER"
    }
}
