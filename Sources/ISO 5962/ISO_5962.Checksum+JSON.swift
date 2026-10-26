public import ISO_5962_License_Expression
public import RFC_8259

extension ISO_5962.Checksum {
    static let keys: Set<String> = ["algorithm", "checksumValue"]

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let algorithm = try members.value("algorithm", Algorithm.init(json:)) else { throw .missing("algorithm") }
        guard let value = try members.string("checksumValue") else { throw .missing("checksumValue") }
        try self.init(algorithm: algorithm, value: try ISO_5962.Members.bytes(value, "checksumValue"))
    }

    public var json: RFC_8259.Value {
        ISO_5962.Members.object([
            ("algorithm", algorithm.json),
            ("checksumValue", .string(ISO_5962.Members.hex(value))),
        ])
    }
}
