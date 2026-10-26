extension ISO_5962.Identifier: CustomStringConvertible {
    public var description: String {
        (document.map { ISO_5962.Identifier.reference + $0 + ":" } ?? "") + ISO_5962.Identifier.prefix + element
    }
}
