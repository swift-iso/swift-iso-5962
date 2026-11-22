public import ISO_5962_License_Expression

extension ISO.`5962`.Identifier: CustomStringConvertible {
    public var description: String {
        (document.map { ISO.`5962`.Identifier.reference + $0 + ":" } ?? "") + ISO.`5962`.Identifier.prefix + element
    }
}
