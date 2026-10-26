public import ISO_5962_License_Expression

extension ISO_5962.Package {
    public struct Reference: Sendable, Hashable {
        public let category: ISO_5962.Package.Reference.Category
        public let type: String
        public let locator: String
        public let comment: String?

        public init(
            category: ISO_5962.Package.Reference.Category,
            type: String,
            locator: String,
            comment: String? = nil
        ) {
            self.category = category
            self.type = type
            self.locator = locator
            self.comment = comment
        }
    }
}
