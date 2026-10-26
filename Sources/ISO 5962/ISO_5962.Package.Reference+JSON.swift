import ECMA_427
public import ISO_5962_License_Expression
public import RFC_8259

extension ISO_5962.Package.Reference {
    static let keys: Set<String> = ["comment", "referenceCategory", "referenceLocator", "referenceType"]

    static let purl = "purl"

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let category = try members.value("referenceCategory", Category.init(json:)) else {
            throw .missing("referenceCategory")
        }
        guard let type = try members.string("referenceType") else { throw .missing("referenceType") }
        guard let locator = try members.string("referenceLocator") else { throw .missing("referenceLocator") }
        self.init(category: category, locator: try Self.locator(type, locator), comment: try members.string("comment"))
    }

    static func locator(_ type: String, _ locator: String) throws(ISO_5962.Error) -> ISO_5962.Package.Reference.Locator {
        guard type == purl else { return .other(type: type, locator: locator) }
        do throws(ECMA_427.Error) {
            return .purl(try ECMA_427.PURL(locator))
        } catch {
            throw .invalid("referenceLocator")
        }
    }

    public var json: RFC_8259.Value {
        let (type, locator): (String, String) =
            switch self.locator {
            case .purl(let purl): (Self.purl, purl.description)
            case .other(let type, let locator): (type, locator)
            }
        return ISO_5962.Members.object([
            ("comment", ISO_5962.Members.text(comment)),
            ("referenceCategory", category.json),
            ("referenceLocator", .string(locator)),
            ("referenceType", .string(type)),
        ])
    }
}
