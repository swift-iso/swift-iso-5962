public import ISO_5962_License_Expression
public import RFC_8259

extension ISO_5962.Package.Reference.Category {
    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        guard let text = json.string, let value = Self(rawValue: text) else { throw .malformed }
        self = value
    }

    public var json: RFC_8259.Value { .string(self.rawValue) }
}
