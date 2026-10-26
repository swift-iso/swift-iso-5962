public import ECMA_427
public import ISO_5962_License_Expression

extension ISO_5962.Package.Reference {
    public enum Locator: Sendable, Hashable {
        case purl(ECMA_427.PURL)
        case other(type: String, locator: String)
    }
}
