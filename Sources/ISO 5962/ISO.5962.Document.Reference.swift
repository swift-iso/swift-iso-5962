public import ISO_5962_License_Expression
public import RFC_3986

extension ISO.`5962`.Document {
    public struct Reference: Sendable, Hashable {
        public let identifier: String
        public let document: IETF.RFC.`3986`.URI
        public let checksum: ISO.`5962`.Checksum

        public init(identifier: String, document: IETF.RFC.`3986`.URI, checksum: ISO.`5962`.Checksum) throws(ISO.`5962`.Error) {
            guard ISO.`5962`.isIdstring(identifier) else { throw .invalid("externalDocumentId") }
            self.identifier = identifier
            self.document = document
            self.checksum = checksum
        }
    }
}
