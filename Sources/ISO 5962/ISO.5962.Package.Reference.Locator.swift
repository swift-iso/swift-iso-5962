public import ECMA_427
public import ISO_5962_License_Expression

extension ISO.`5962`.Package.Reference {
    public enum Locator: Sendable, Hashable {
        case purl(ECMA.`427`.PURL)
        case other(type: String, locator: String)
    }
}
