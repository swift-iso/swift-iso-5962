public import ISO_5962_License_Expression

extension ISO.`5962` {
    public struct Relationship: Sendable, Hashable {
        public let element: ISO.`5962`.Identifier
        public let kind: ISO.`5962`.Relationship.Kind
        public let related: ISO.`5962`.Assertion<ISO.`5962`.Identifier>
        public let comment: String?

        public init(
            element: ISO.`5962`.Identifier,
            kind: ISO.`5962`.Relationship.Kind,
            related: ISO.`5962`.Assertion<ISO.`5962`.Identifier>,
            comment: String? = nil
        ) {
            self.element = element
            self.kind = kind
            self.related = related
            self.comment = comment
        }
    }
}
