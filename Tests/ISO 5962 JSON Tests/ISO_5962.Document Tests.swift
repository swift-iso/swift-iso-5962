import ECMA_427
import ISO_5962
import ISO_5962_License_Expression
import ISO_8601
import JSON
import RFC_8259
import Testing

extension ISO_5962.Document {
    @Suite struct Test {
        @Suite struct Integration {}
    }
}

extension ISO_5962.Document.Test {
    static func example() throws -> ISO_5962.Document {
        try ISO_5962.Document(json: RFC_8259.Value(try JSON.parse(ISO_5962.Document.Test.Example.document)))
    }
}

extension ISO_5962.Document.Test.Integration {

    @Test
    func `the example document round-trips through JSON text`() throws {
        let document = try ISO_5962.Document.Test.example()
        let text = JSON(document.json).serialize()
        #expect(try ISO_5962.Document(json: RFC_8259.Value(try JSON.parse(text))) == document)
    }

    @Test
    func `the example's package manager reference is a package URL`() throws {
        let document = try ISO_5962.Document.Test.example()
        let doap = try #require(document.packages.first { $0.identifier.element == "fromDoap-0" })
        let expected = try ECMA_427.PURL("pkg:maven/org.apache.jena/apache-jena@3.12.0")
        #expect(doap.externalRefs.first?.locator == .purl(expected))
        #expect(doap.externalRefs.first?.category == .packageManager)
    }

    @Test
    func `the SPDX 2.2 example document round-trips through its JSON value`() throws {
        let document = try ISO_5962.Document.Test.example()
        #expect(try ISO_5962.Document(json: document.json) == document)
    }

    @Test
    func `the example's document information is read`() throws {
        let document = try ISO_5962.Document.Test.example()
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
        let document = try ISO_5962.Document.Test.example()
        let glibc = try #require(document.packages.first)
        let expected: [ISO_5962.Checksum.Algorithm] = [.md5, .sha1, .sha256]
        #expect(glibc.identifier.element == "Package")
        #expect(glibc.supplier == .value(.person("Jane Doe (jane.doe@example.com)")))
        #expect(glibc.licenseConcluded == .value(.disjunction(.simple(.license("LGPL-2.0-only")), .simple(.reference("3", document: nil)))))
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
        let document = try ISO_5962.Document.Test.example()
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
        let document = try ISO_5962.Document.Test.example()
        let file = try #require(document.files.first { $0.identifier.element == "File" })
        let types: [ISO_5962.File.Kind] = [.source]
        #expect(file.types == types)
        #expect(file.licenseInfoInFiles == [.value(.license("GPL-2.0-only")), .value(.reference("2", document: nil))])
        #expect(document.hasExtractedLicensingInfos.map(\.identifier) == ["1", "2", "4", "Beerware-4.2", "3"])
        #expect(document.annotations.map(\.kind) == [.other, .review, .review])
    }
}
