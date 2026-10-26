extension ISO_5962.Package.Reference {
    public enum Category: String, Sendable, Hashable, CaseIterable {
        case other = "OTHER"
        case security = "SECURITY"
        case packageManager = "PACKAGE_MANAGER"
    }
}
