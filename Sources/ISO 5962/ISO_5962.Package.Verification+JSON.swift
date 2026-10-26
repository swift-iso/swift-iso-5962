public import RFC_8259

extension ISO_5962.Package.Verification {
    static let keys: Set<String> = ["packageVerificationCodeValue", "packageVerificationCodeExcludedFiles"]

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let value = try members.string("packageVerificationCodeValue") else {
            throw .missing("packageVerificationCodeValue")
        }
        try self.init(
            value: try ISO_5962.Members.bytes(value, "packageVerificationCodeValue"),
            excluded: try members.strings("packageVerificationCodeExcludedFiles")
        )
    }

    public var json: RFC_8259.Value {
        ISO_5962.Members.object([
            ("packageVerificationCodeValue", .string(ISO_5962.Members.hex(value))),
            ("packageVerificationCodeExcludedFiles", ISO_5962.Members.strings(excluded)),
        ])
    }
}
