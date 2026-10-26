public import RFC_3986

extension ISO_5962.Document {
    public struct Reference: Sendable, Hashable {
        public let identifier: String
        public let document: RFC_3986.URI
        public let checksum: ISO_5962.Checksum

        public init(identifier: String, document: RFC_3986.URI, checksum: ISO_5962.Checksum) throws(ISO_5962.Error) {
            guard ISO_5962.Identifier.isValid(identifier) else { throw .invalid("externalDocumentId") }
            self.identifier = identifier
            self.document = document
            self.checksum = checksum
        }
    }
}
