public import ISO_5962_License_Expression
public import RFC_8259

extension ISO.`5962`.Relationship {
    static let keys: Set<String> = ["spdxElementId", "comment", "relationshipType", "relatedSpdxElement"]

    public init(json: IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) {
        let members = try ISO.`5962`.Members(json, known: Self.keys)
        guard let element = try members.value("spdxElementId", ISO.`5962`.Identifier.init(json:)) else {
            throw .missing("spdxElementId")
        }
        guard let kind = try members.value("relationshipType", Kind.init(json:)) else { throw .missing("relationshipType") }
        guard let related = try members.assertion("relatedSpdxElement", ISO.`5962`.Identifier.init(json:)) else {
            throw .missing("relatedSpdxElement")
        }
        self.init(element: element, kind: kind, related: related, comment: try members.string("comment"))
    }

    public var json: IETF.RFC.`8259`.Value {
        ISO.`5962`.Members.object([
            ("spdxElementId", element.json),
            ("relationshipType", kind.json),
            ("relatedSpdxElement", related.json(\.json)),
            ("comment", ISO.`5962`.Members.text(comment)),
        ])
    }
}
