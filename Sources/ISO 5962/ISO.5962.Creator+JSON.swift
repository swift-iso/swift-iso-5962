public import ISO_5962_License_Expression
public import RFC_8259

extension ISO.`5962`.Creator {
    public init(json: IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) {
        guard let text = json.string, let colon = text.firstIndex(of: ":") else { throw .malformed }
        let name = String(text[text.index(after: colon)...].drop { $0 == " " })
        switch text[..<colon] {
        case "Person": self = .person(name)
        case "Organization": self = .organization(name)
        case "Tool": self = .tool(name)
        default: throw .malformed
        }
    }

    static func party(_ json: IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> ISO.`5962`.Creator {
        let creator = try ISO.`5962`.Creator(json: json)
        guard case .tool = creator else { return creator }
        throw .malformed
    }

    public var json: IETF.RFC.`8259`.Value {
        switch self {
        case .person(let name): .string("Person: " + name)
        case .organization(let name): .string("Organization: " + name)
        case .tool(let name): .string("Tool: " + name)
        }
    }
}
