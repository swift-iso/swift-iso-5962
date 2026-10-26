import Byte
import ISO_5962
import ISO_8601
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
    func `the SPDX 2.2 example document round-trips through its JSON value`() throws {
        let document = try ISO_5962.Document(json: ISO_5962.Document.Test.Example.document)
        #expect(try ISO_5962.Document(json: document.json) == document)
    }

    @Test
    func `the example's document information is read`() throws {
        let document = try ISO_5962.Document(json: ISO_5962.Document.Test.Example.document)
        let created = try ISO_8601.DateTime("2010-01-29T18:30:22Z")
        #expect(document.name == "SPDX-Tools-v2.0")
        #expect(document.namespace.value == "http://spdx.org/spdxdocs/spdx-example-444504E0-4F89-41D3-9A0C-0305E82C3301")
        #expect(document.creationInfo.created == created)
        #expect(document.creationInfo.licenseListVersion == "3.9")
        #expect(
            document.creationInfo.creators == [
                .tool("LicenseFind-1.0"), .organization("ExampleCodeInspect ()"), .person("Jane Doe ()"),
            ]
        )
        #expect(document.describes.map(\.description) == ["SPDXRef-File", "SPDXRef-Package"])
        #expect(document.json["spdxVersion"] == "SPDX-2.2")
        #expect(document.json["dataLicense"] == "CC0-1.0")
    }

    @Test
    func `the example's packages carry assertions, checksums and references`() throws {
        let document = try ISO_5962.Document(json: ISO_5962.Document.Test.Example.document)
        let glibc = try #require(document.packages.first)
        let expected: [ISO_5962.Checksum.Algorithm] = [.md5, .sha1, .sha256]
        #expect(glibc.identifier.element == "Package")
        #expect(glibc.supplier == .value(.person("Jane Doe (jane.doe@example.com)")))
        #expect(glibc.licenseConcluded == .value("(LGPL-2.0-only OR LicenseRef-3)"))
        #expect(glibc.checksums.map(\.algorithm) == expected)
        #expect(glibc.externalRefs.first?.category == .security)
        guard case .analyzed(let verification) = glibc.analysis else {
            Issue.record("expected an analyzed package")
            return
        }
        #expect(verification?.excluded == ["./package.spdx"])
        let doap = try #require(document.packages.first { $0.identifier.element == "fromDoap-1" })
        #expect(doap.downloadLocation == .unasserted)
        #expect(doap.copyrightText == .unasserted)
        #expect(doap.analysis == .unanalyzed)
    }

    @Test
    func `the example's relationships may point into another document or at nothing asserted`() throws {
        let document = try ISO_5962.Document(json: ISO_5962.Document.Test.Example.document)
        let copy = try #require(document.relationships.first { $0.kind == .copyOf })
        let tools = try ISO_5962.Identifier("ToolsElement", document: "spdx-tool-1.2")
        #expect(copy.related == .value(tools))
        #expect(copy.related != .unasserted)
        let generated = try #require(document.relationships.first { $0.kind == .generatedFrom })
        #expect(generated.related == .unasserted)
        #expect(document.externalDocumentRefs.first?.identifier == "spdx-tool-1.2")
        #expect(document.externalDocumentRefs.first?.checksum.algorithm == .sha1)
    }

    @Test
    func `the example's files and extracted licenses are read`() throws {
        let document = try ISO_5962.Document(json: ISO_5962.Document.Test.Example.document)
        let file = try #require(document.files.first { $0.identifier.element == "File" })
        let types: [ISO_5962.File.Kind] = [.source]
        #expect(file.types == types)
        #expect(file.licenseInfoInFiles == [.value("GPL-2.0-only"), .value("LicenseRef-2")])
        #expect(document.hasExtractedLicensingInfos.map(\.identifier) == ["1", "2", "4", "Beerware-4.2", "3"])
        #expect(document.annotations.map(\.kind) == [.other, .review, .review])
    }

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
            licenseDeclared: .value("Apache-2.0"),
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
    func `uppercase checksum values are read and written lowercase`() throws {
        let checksum = try ISO_5962.Checksum(json: ["algorithm": "MD5", "checksumValue": "624C1ABB3664F4B35547E7C73864AD24"])
        #expect(checksum.json["checksumValue"] == "624c1abb3664f4b35547e7c73864ad24")
    }
}
