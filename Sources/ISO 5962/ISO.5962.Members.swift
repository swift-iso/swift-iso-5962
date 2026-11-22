import Binary
import Byte
import ISO_5962_License_Expression
import RFC_3986
import RFC_8259

extension ISO.`5962` {
    struct Members {
        let object: IETF.RFC.`8259`.Object

        init(_ json: IETF.RFC.`8259`.Value, known: Swift::Set<Swift::String>) throws(ISO.`5962`.Error) {
            guard let object = json.object else { throw .malformed }
            if let unknown = object.keys.first(where: { !known.contains($0) }) {
                throw .unexpected(unknown)
            }
            self.object = object
        }
    }
}

extension ISO.`5962`.Members {
    func string(_ key: String) throws(ISO.`5962`.Error) -> String? {
        guard let member = object[key] else { return nil }
        guard let text = member.string else { throw .invalid(key) }
        return text
    }

    func uri(_ key: String) throws(ISO.`5962`.Error) -> IETF.RFC.`3986`.URI? {
        try value(key, Self.uri)
    }

    func boolean(_ key: String) throws(ISO.`5962`.Error) -> Bool? {
        guard let member = object[key] else { return nil }
        guard let flag = member.bool else { throw .invalid(key) }
        return flag
    }

    func assertion<Value>(
        _ key: String,
        _ decode: (IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> Value
    ) throws(ISO.`5962`.Error) -> ISO.`5962`.Assertion<Value>? {
        try value(key) { json throws(ISO.`5962`.Error) in try ISO.`5962`.Assertion(json: json, decode) }
    }

    func assertions<Value>(
        _ key: String,
        _ decode: (IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> Value
    ) throws(ISO.`5962`.Error) -> [ISO.`5962`.Assertion<Value>] {
        try values(key) { json throws(ISO.`5962`.Error) in try ISO.`5962`.Assertion(json: json, decode) }
    }

    func value<Value>(
        _ key: String,
        _ decode: (IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> Value
    ) throws(ISO.`5962`.Error) -> Value? {
        guard let member = object[key] else { return nil }
        return try Self.within(key, member, decode)
    }

    func values<Value>(
        _ key: String,
        _ decode: (IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> Value
    ) throws(ISO.`5962`.Error) -> [Value] {
        guard let member = object[key] else { return [] }
        guard let array = member.array else { throw .invalid(key) }
        return try array.map { element throws(ISO.`5962`.Error) in
            try Self.within(key, element, decode)
        }
    }

    func strings(_ key: String) throws(ISO.`5962`.Error) -> [String] {
        try values(key) { element throws(ISO.`5962`.Error) in try Self.text(element, key) }
    }
}

extension ISO.`5962`.Members {
    static func within<Value>(
        _ key: String,
        _ json: IETF.RFC.`8259`.Value,
        _ decode: (IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> Value
    ) throws(ISO.`5962`.Error) -> Value {
        do throws(ISO.`5962`.Error) {
            return try decode(json)
        } catch {
            throw error == .malformed ? .invalid(key) : error
        }
    }

    static func text(_ json: IETF.RFC.`8259`.Value, _ key: String) throws(ISO.`5962`.Error) -> String {
        guard let text = json.string else { throw .invalid(key) }
        return text
    }

    static func uri(_ json: IETF.RFC.`8259`.Value) throws(ISO.`5962`.Error) -> IETF.RFC.`3986`.URI {
        guard let text = json.string else { throw .malformed }
        do throws(IETF.RFC.`3986`.Error) {
            return try IETF.RFC.`3986`.URI(text)
        } catch {
            throw .malformed
        }
    }

}

extension ISO.`5962`.Members {
    static let alphabet: [Byte] = "0123456789abcdef".utf8.map(Byte.init(bitPattern:))

    static func bytes(_ text: String, _ key: String) throws(ISO.`5962`.Error) -> [Byte] {
        guard let bytes = Binary.Base.`16`.decode(text.lowercased(), alphabet: alphabet) else {
            throw .invalid(key)
        }
        return bytes
    }

    static func hex(_ bytes: [Byte]) -> String {
        Binary.Base.`16`.encode(bytes, alphabet: alphabet)
    }
}

extension ISO.`5962`.Members {
    static func object(_ members: [(key: String, value: IETF.RFC.`8259`.Value?)]) -> IETF.RFC.`8259`.Value {
        .object(
            IETF.RFC.`8259`.Object(
                members.compactMap { member in member.value.map { (key: member.key, value: $0) } }
            )
        )
    }

    static func text(_ value: String?) -> IETF.RFC.`8259`.Value? {
        value.map { IETF.RFC.`8259`.Value.string($0) }
    }

    static func asserted<Value: CustomStringConvertible>(_ assertion: ISO.`5962`.Assertion<Value>) -> IETF.RFC.`8259`.Value {
        assertion.json { IETF.RFC.`8259`.Value.string($0.description) }
    }

    static func array(_ elements: [IETF.RFC.`8259`.Value]) -> IETF.RFC.`8259`.Value? {
        elements.isEmpty ? nil : .array(IETF.RFC.`8259`.Array(elements))
    }

    static func strings(_ elements: [String]) -> IETF.RFC.`8259`.Value? {
        array(elements.map { IETF.RFC.`8259`.Value.string($0) })
    }
}
