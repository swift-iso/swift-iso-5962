public import ISO_5962_License_Expression
public import RFC_8259

extension ISO_5962.License {
    static let keys: Set<String> = ["seeAlsos", "name", "comment", "crossRefs", "licenseId", "extractedText"]

    static let prefix = "LicenseRef-"

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let id = try members.string("licenseId") else { throw .missing("licenseId") }
        guard id.hasPrefix(Self.prefix) else { throw .invalid("licenseId") }
        guard let text = try members.string("extractedText") else { throw .missing("extractedText") }
        try self.init(
            identifier: String(id.dropFirst(Self.prefix.count)),
            text: text,
            name: try members.string("name"),
            seeAlsos: try members.strings("seeAlsos"),
            comment: try members.string("comment")
        )
    }

    public var json: RFC_8259.Value {
        ISO_5962.Members.object([
            ("licenseId", .string(Self.prefix + identifier)),
            ("extractedText", .string(text)),
            ("name", ISO_5962.Members.text(name)),
            ("seeAlsos", ISO_5962.Members.strings(seeAlsos)),
            ("comment", ISO_5962.Members.text(comment)),
        ])
    }
}
