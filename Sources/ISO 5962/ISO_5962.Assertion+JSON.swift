import RFC_8259

extension ISO_5962.Assertion {
    init(
        json: RFC_8259.Value,
        _ decode: (RFC_8259.Value) throws(ISO_5962.Error) -> Value
    ) throws(ISO_5962.Error) {
        switch json.string {
        case "NONE": self = .absent
        case "NOASSERTION": self = .unasserted
        default: self = .value(try decode(json))
        }
    }

    func json(_ encode: (Value) -> RFC_8259.Value) -> RFC_8259.Value {
        switch self {
        case .value(let value): encode(value)
        case .absent: .string("NONE")
        case .unasserted: .string("NOASSERTION")
        }
    }
}
