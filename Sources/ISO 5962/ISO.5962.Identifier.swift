public import ISO_5962_License_Expression

extension ISO.`5962` {
    public struct Identifier: Sendable, Hashable {
        public let document: String?
        public let element: String

        public init(_ element: String, document: String? = nil) throws(ISO.`5962`.Error) {
            guard ISO.`5962`.isIdstring(element), document.map({ ISO.`5962`.isIdstring($0) }) ?? true else {
                throw .invalid("SPDXID")
            }
            self.document = document
            self.element = element
        }
    }
}
