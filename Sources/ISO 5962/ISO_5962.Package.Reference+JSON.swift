public import RFC_8259

extension ISO_5962.Package.Reference {
    static let keys: Set<String> = ["comment", "referenceCategory", "referenceLocator", "referenceType"]

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let category = try members.value("referenceCategory", Category.init(json:)) else {
            throw .missing("referenceCategory")
        }
        guard let type = try members.string("referenceType") else { throw .missing("referenceType") }
        guard let locator = try members.string("referenceLocator") else { throw .missing("referenceLocator") }
        self.init(category: category, type: type, locator: locator, comment: try members.string("comment"))
    }

    public var json: RFC_8259.Value {
        ISO_5962.Members.object([
            ("comment", ISO_5962.Members.text(comment)),
            ("referenceCategory", category.json),
            ("referenceLocator", .string(locator)),
            ("referenceType", .string(type)),
        ])
    }
}
