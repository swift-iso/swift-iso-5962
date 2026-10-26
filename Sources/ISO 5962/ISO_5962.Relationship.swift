public import ISO_5962_License_Expression

extension ISO_5962 {
    public struct Relationship: Sendable, Hashable {
        public let element: ISO_5962.Identifier
        public let kind: ISO_5962.Relationship.Kind
        public let related: ISO_5962.Assertion<ISO_5962.Identifier>
        public let comment: String?

        public init(
            element: ISO_5962.Identifier,
            kind: ISO_5962.Relationship.Kind,
            related: ISO_5962.Assertion<ISO_5962.Identifier>,
            comment: String? = nil
        ) {
            self.element = element
            self.kind = kind
            self.related = related
            self.comment = comment
        }
    }
}
