public import ISO_5962_License_Expression

extension ISO_5962 {
    public struct Identifier: Sendable, Hashable {
        public let document: String?
        public let element: String

        public init(_ element: String, document: String? = nil) throws(ISO_5962.Error) {
            guard ISO_5962.isIdstring(element), document.map { ISO_5962.isIdstring($0) } ?? true else {
                throw .invalid("SPDXID")
            }
            self.document = document
            self.element = element
        }
    }
}
