import ISO_5962_License_Expression
import RFC_8259

extension ISO.`5962`.Assertion {
    init(
        json: IETF.RFC.`8259`.Value,
        _ decode: (IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> Value
    ) throws(ISO.`5962`.Error) {
        switch json.string {
        case "NONE": self = .absent
        case "NOASSERTION": self = .unasserted
        default: self = .value(try decode(json))
        }
    }

    func json(_ encode: (Value) -> IETF.RFC.`8259`.Value) -> IETF.RFC.`8259`.Value {
        switch self {
        case .value(let value): encode(value)
        case .absent: .string("NONE")
        case .unasserted: .string("NOASSERTION")
        }
    }
}
