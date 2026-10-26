extension ISO_5962 {
    public struct License: Sendable, Hashable {
        public let identifier: String
        public let text: String
        public let name: String?
        public let seeAlsos: [String]
        public let comment: String?

        public init(
            identifier: String,
            text: String,
            name: String? = nil,
            seeAlsos: [String] = [],
            comment: String? = nil
        ) throws(ISO_5962.Error) {
            guard ISO_5962.Identifier.isValid(identifier) else { throw .invalid("licenseId") }
            self.identifier = identifier
            self.text = text
            self.name = name
            self.seeAlsos = seeAlsos
            self.comment = comment
        }
    }
}
