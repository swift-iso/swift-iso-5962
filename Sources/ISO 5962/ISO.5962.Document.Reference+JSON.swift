public import ISO_5962_License_Expression
import RFC_3986
public import RFC_8259

extension ISO.`5962`.Document.Reference {
    static let keys: Set<String> = ["externalDocumentId", "checksum", "spdxDocument"]

    public init(json: IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) {
        let members = try ISO.`5962`.Members(json, known: Self.keys)
        guard let id = try members.string("externalDocumentId") else { throw .missing("externalDocumentId") }
        guard id.hasPrefix(ISO.`5962`.Identifier.reference) else { throw .invalid("externalDocumentId") }
        guard let checksum = try members.value("checksum", ISO.`5962`.Checksum.init(json:)) else { throw .missing("checksum") }
        guard let document = try members.uri("spdxDocument") else { throw .missing("spdxDocument") }
        try self.init(
            identifier: String(id.dropFirst(ISO.`5962`.Identifier.reference.count)),
            document: document,
            checksum: checksum
        )
    }

    public var json: IETF.RFC.`8259`.Value {
        ISO.`5962`.Members.object([
            ("externalDocumentId", .string(ISO.`5962`.Identifier.reference + identifier)),
            ("checksum", checksum.json),
            ("spdxDocument", .string(document.value)),
        ])
    }
}
