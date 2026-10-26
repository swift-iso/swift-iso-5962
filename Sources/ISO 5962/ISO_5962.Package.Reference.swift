public import ISO_5962_License_Expression

extension ISO_5962.Package {
    public struct Reference: Sendable, Hashable {
        public let category: ISO_5962.Package.Reference.Category
        public let locator: ISO_5962.Package.Reference.Locator
        public let comment: String?

        public init(
            category: ISO_5962.Package.Reference.Category,
            locator: ISO_5962.Package.Reference.Locator,
            comment: String? = nil
        ) {
            self.category = category
            self.locator = locator
            self.comment = comment
        }
    }
}
