public import ISO_5962_License_Expression

extension ISO_5962.Identifier: CustomStringConvertible {
    public var description: String {
        (document.map { ISO_5962.Identifier.reference + $0 + ":" } ?? "") + ISO_5962.Identifier.prefix + element
    }
}
