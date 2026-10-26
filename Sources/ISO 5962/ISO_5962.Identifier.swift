extension ISO_5962 {
    public struct Identifier: Sendable, Hashable {
        public let document: String?
        public let element: String

        public init(_ element: String, document: String? = nil) throws(ISO_5962.Error) {
            guard ISO_5962.Identifier.isValid(element), document.map(ISO_5962.Identifier.isValid) ?? true else {
                throw .invalid("SPDXID")
            }
            self.document = document
            self.element = element
        }
    }
}
