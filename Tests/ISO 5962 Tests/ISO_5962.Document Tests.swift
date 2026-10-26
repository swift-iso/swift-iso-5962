import Byte
import ISO_5962
import ISO_5962_License_Expression
import RFC_3986
import RFC_8259
import Testing

extension ISO_5962.Document {
    @Suite struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
    }
}

extension ISO_5962.Document.Test {
    static func minimal(
        _ members: [(key: String, value: RFC_8259.Value)] = []
    ) -> RFC_8259.Value {
        var object = RFC_8259.Object([
            ("spdxVersion", "SPDX-2.2"),
            ("dataLicense", "CC0-1.0"),
            ("SPDXID", "SPDXRef-DOCUMENT"),
            ("name", "minimal"),
            ("documentNamespace", "https://swift-institute.org/spdx/minimal"),
            ("creationInfo", ["created": "2026-10-26T12:00:00Z", "creators": ["Tool: swift-iso-5962"]]),
        ])
        for member in members { object[member.key] = member.value }
        return .object(object)
    }

    static func package(_ members: [(key: String, value: RFC_8259.Value)] = []) -> RFC_8259.Value {
        var object = RFC_8259.Object([
            ("SPDXID", "SPDXRef-Package"),
            ("name", "package"),
            ("downloadLocation", "NOASSERTION"),
            ("licenseConcluded", "NOASSERTION"),
            ("licenseDeclared", "NOASSERTION"),
            ("copyrightText", "NOASSERTION"),
        ])
        for member in members { object[member.key] = member.value }
        return .object(object)
    }
}

extension ISO_5962.Document.Test.Unit {

    @Test
    func `a minimal document carries the fixed members and round-trips`() throws {
        let document = try ISO_5962.Document(json: ISO_5962.Document.Test.minimal())
        #expect(document.json["SPDXID"] == "SPDXRef-DOCUMENT")
        #expect(document.json["creationInfo"]?["created"] == "2026-10-26T12:00:00Z")
        #expect(try ISO_5962.Document(json: document.json) == document)
    }

    @Test
    func `a built package serializes NONE and NOASSERTION`() throws {
        let package = ISO_5962.Package(
            identifier: try ISO_5962.Identifier("swift-rfc-8259"),
            name: "swift-rfc-8259",
            downloadLocation: .value(try RFC_3986.URI("git+https://github.com/swift-ietf/swift-rfc-8259.git")),
            analysis: .unanalyzed,
            checksums: [
                try ISO_5962.Checksum(algorithm: .sha256, value: [Byte](repeating: Byte(bitPattern: 0x0F), count: 32))
            ],
            licenseConcluded: .unasserted,
            licenseDeclared: .value(.simple(.license("Apache-2.0"))),
            copyrightText: .absent
        )
        #expect(package.json["licenseConcluded"] == "NOASSERTION")
        #expect(package.json["copyrightText"] == "NONE")
        #expect(package.json["filesAnalyzed"] == false)
        #expect(package.json["checksums"]?[0]?["checksumValue"] == .string(String(repeating: "0f", count: 32)))
        #expect(try ISO_5962.Package(json: package.json) == package)
    }
}

extension ISO_5962.Document.Test.`Edge Case` {

    @Test(arguments: ["spdxVersion", "dataLicense", "SPDXID", "name", "documentNamespace", "creationInfo"])
    func `every required document member is required`(member: String) {
        guard case .object(var object) = ISO_5962.Document.Test.minimal() else { return }
        object[member] = nil
        #expect(throws: ISO_5962.Error.missing(member)) { try ISO_5962.Document(json: .object(object)) }
    }

    @Test
    func `another SPDX version is refused`() {
        #expect(throws: ISO_5962.Error.invalid("spdxVersion")) {
            try ISO_5962.Document(json: ISO_5962.Document.Test.minimal([("spdxVersion", "SPDX-2.3")]))
        }
    }

    @Test
    func `another data license is refused`() {
        #expect(throws: ISO_5962.Error.invalid("dataLicense")) {
            try ISO_5962.Document(json: ISO_5962.Document.Test.minimal([("dataLicense", "MIT")]))
        }
    }

    @Test
    func `the document identifier is fixed`() {
        #expect(throws: ISO_5962.Error.invalid("SPDXID")) {
            try ISO_5962.Document(json: ISO_5962.Document.Test.minimal([("SPDXID", "SPDXRef-Other")]))
        }
    }

    @Test
    func `a namespace with a fragment is refused`() {
        #expect(throws: ISO_5962.Error.invalid("documentNamespace")) {
            try ISO_5962.Document(json: ISO_5962.Document.Test.minimal([("documentNamespace", "https://example.com/doc#part")]))
        }
    }

    @Test
    func `creation needs at least one creator`() {
        #expect(throws: ISO_5962.Error.missing("creators")) {
            try ISO_5962.Document(
                json: ISO_5962.Document.Test.minimal([("creationInfo", ["created": "2026-10-26T12:00:00Z", "creators": []])])
            )
        }
    }

    @Test
    func `the creation time is in UTC`() {
        #expect(throws: ISO_5962.Error.invalid("created")) {
            try ISO_5962.Document(
                json: ISO_5962.Document.Test.minimal([
                    ("creationInfo", ["created": "2026-10-26T12:00:00+02:00", "creators": ["Tool: swift-iso-5962"]])
                ])
            )
        }
    }

    @Test
    func `a creator without a known prefix is refused`() {
        #expect(throws: ISO_5962.Error.invalid("creators")) {
            try ISO_5962.Document(
                json: ISO_5962.Document.Test.minimal([("creationInfo", ["created": "2026-10-26T12:00:00Z", "creators": ["Robot: x"]])])
            )
        }
    }

    @Test
    func `a member the schema does not define is refused`() {
        #expect(throws: ISO_5962.Error.unexpected("spdxversion")) {
            try ISO_5962.Document(json: ISO_5962.Document.Test.minimal([("spdxversion", "SPDX-2.2")]))
        }
    }

    @Test(arguments: ["SPDXID", "name", "downloadLocation", "licenseConcluded", "licenseDeclared", "copyrightText"])
    func `every required package member is required`(member: String) {
        guard case .object(var object) = ISO_5962.Document.Test.package() else { return }
        object[member] = nil
        #expect(throws: ISO_5962.Error.missing(member)) { try ISO_5962.Package(json: .object(object)) }
    }

    @Test
    func `a package identifier needs the SPDXRef prefix and an idstring`() {
        #expect(throws: ISO_5962.Error.invalid("SPDXID")) {
            try ISO_5962.Package(json: ISO_5962.Document.Test.package([("SPDXID", "Package")]))
        }
        #expect(throws: ISO_5962.Error.invalid("SPDXID")) {
            try ISO_5962.Package(json: ISO_5962.Document.Test.package([("SPDXID", "SPDXRef-a b")]))
        }
    }

    @Test
    func `a tool cannot be a supplier`() {
        #expect(throws: ISO_5962.Error.invalid("supplier")) {
            try ISO_5962.Package(json: ISO_5962.Document.Test.package([("supplier", "Tool: x")]))
        }
    }

    @Test
    func `an unanalyzed package carries no verification code`() {
        #expect(throws: ISO_5962.Error.unexpected("packageVerificationCode")) {
            try ISO_5962.Package(
                json: ISO_5962.Document.Test.package([
                    ("filesAnalyzed", false),
                    ("packageVerificationCode", ["packageVerificationCodeValue": "d6a770ba38583ed4bb4525bd96e50461655d2758"]),
                ])
            )
        }
    }

    @Test
    func `a checksum must have its algorithm's length`() {
        #expect(throws: ISO_5962.Error.invalid("checksumValue")) {
            try ISO_5962.Checksum(json: ["algorithm": "SHA256", "checksumValue": "d6a770ba38583ed4bb4525bd96e50461655d2758"])
        }
        #expect(throws: ISO_5962.Error.invalid("algorithm")) {
            try ISO_5962.Checksum(json: ["algorithm": "SHA3-256", "checksumValue": "d6a770ba38583ed4bb4525bd96e50461655d2758"])
        }
    }

    @Test
    func `a file needs a checksum and a license information entry`() {
        let base: [(key: String, value: RFC_8259.Value)] = [
            ("SPDXID", "SPDXRef-File"), ("fileName", "./a.swift"), ("licenseConcluded", "NOASSERTION"),
            ("copyrightText", "NONE"),
        ]
        let checksum: RFC_8259.Value = ["algorithm": "SHA1", "checksumValue": "d6a770ba38583ed4bb4525bd96e50461655d2758"]
        #expect(throws: ISO_5962.Error.missing("checksums")) {
            try ISO_5962.File(json: .object(RFC_8259.Object(base + [("licenseInfoInFiles", ["NOASSERTION"])])))
        }
        #expect(throws: ISO_5962.Error.missing("licenseInfoInFiles")) {
            try ISO_5962.File(json: .object(RFC_8259.Object(base + [("checksums", [checksum])])))
        }
    }

    @Test
    func `an unknown relationship type is refused`() {
        #expect(throws: ISO_5962.Error.invalid("relationshipType")) {
            try ISO_5962.Relationship(
                json: ["spdxElementId": "SPDXRef-DOCUMENT", "relationshipType": "REQUIREMENT_DESCRIPTION_FOR", "relatedSpdxElement": "SPDXRef-A"]
            )
        }
    }

    @Test
    func `an extracted license needs the LicenseRef prefix`() {
        #expect(throws: ISO_5962.Error.invalid("licenseId")) {
            try ISO_5962.License(json: ["licenseId": "MIT", "extractedText": "text"])
        }
    }

    @Test
    func `a license expression that does not parse is refused`() {
        #expect(throws: ISO_5962.Error.invalid("licenseConcluded")) {
            try ISO_5962.Package(json: ISO_5962.Document.Test.package([("licenseConcluded", "MIT AND")]))
        }
        #expect(throws: ISO_5962.Error.invalid("licenseInfoFromFiles")) {
            try ISO_5962.Package(json: ISO_5962.Document.Test.package([("licenseInfoFromFiles", ["MIT OR Apache-2.0"])]))
        }
    }

    @Test
    func `uppercase checksum values are read and written lowercase`() throws {
        let checksum = try ISO_5962.Checksum(json: ["algorithm": "MD5", "checksumValue": "624C1ABB3664F4B35547E7C73864AD24"])
        #expect(checksum.json["checksumValue"] == "624c1abb3664f4b35547e7c73864ad24")
    }
}
