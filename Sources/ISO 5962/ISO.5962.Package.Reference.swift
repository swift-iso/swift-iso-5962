public import ISO_5962_License_Expression

extension ISO.`5962`.Package {
    public struct Reference: Sendable, Hashable {
        public let category: ISO.`5962`.Package.Reference.Category
        public let locator: ISO.`5962`.Package.Reference.Locator
        public let comment: String?

        public init(
            category: ISO.`5962`.Package.Reference.Category,
            locator: ISO.`5962`.Package.Reference.Locator,
            comment: String? = nil
        ) {
            self.category = category
            self.locator = locator
            self.comment = comment
        }
    }
}
