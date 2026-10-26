public import ISO_8601

extension ISO_5962 {
    public struct Creation: Sendable, Hashable {
        public let created: ISO_8601.DateTime
        public let creators: [ISO_5962.Creator]
        public let licenseListVersion: String?
        public let comment: String?

        public init(
            created: ISO_8601.DateTime,
            creators: [ISO_5962.Creator],
            licenseListVersion: String? = nil,
            comment: String? = nil
        ) throws(ISO_5962.Error) {
            guard created.offset == .utc else { throw .invalid("created") }
            guard !creators.isEmpty else { throw .missing("creators") }
            self.created = created
            self.creators = creators
            self.licenseListVersion = licenseListVersion
            self.comment = comment
        }
    }
}
