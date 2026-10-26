public import ISO_5962_License_Expression
import RFC_3986
public import RFC_8259

extension ISO_5962.Package {
    static let keys: Set<String> = [
        "SPDXID", "attributionTexts", "annotations", "supplier", "homepage", "licenseDeclared", "packageVerificationCode",
        "checksums", "downloadLocation", "filesAnalyzed", "externalRefs", "licenseComments", "name", "hasFiles", "comment",
        "copyrightText", "summary", "originator", "packageFileName", "licenseInfoFromFiles", "licenseConcluded",
        "versionInfo", "sourceInfo", "description",
    ]

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let identifier = try members.value("SPDXID", ISO_5962.Identifier.init(json:)) else { throw .missing("SPDXID") }
        guard let name = try members.string("name") else { throw .missing("name") }
        guard let downloadLocation = try members.assertion("downloadLocation", ISO_5962.Members.uri) else {
            throw .missing("downloadLocation")
        }
        guard let licenseConcluded = try members.assertion("licenseConcluded", Self.expression) else {
            throw .missing("licenseConcluded")
        }
        guard let licenseDeclared = try members.assertion("licenseDeclared", Self.expression) else {
            throw .missing("licenseDeclared")
        }
        guard let copyrightText = try members.assertion("copyrightText", Self.text) else {
            throw .missing("copyrightText")
        }
        self.init(
            identifier: identifier,
            name: name,
            versionInfo: try members.string("versionInfo"),
            fileName: try members.string("packageFileName"),
            supplier: try members.assertion("supplier", ISO_5962.Creator.party),
            originator: try members.assertion("originator", ISO_5962.Creator.party),
            downloadLocation: downloadLocation,
            analysis: try Self.analysis(members),
            checksums: try members.values("checksums", ISO_5962.Checksum.init(json:)),
            homepage: try members.assertion("homepage", ISO_5962.Members.uri),
            sourceInfo: try members.string("sourceInfo"),
            licenseConcluded: licenseConcluded,
            licenseInfoFromFiles: try members.assertions("licenseInfoFromFiles", Self.simple),
            licenseDeclared: licenseDeclared,
            licenseComments: try members.string("licenseComments"),
            copyrightText: copyrightText,
            summary: try members.string("summary"),
            description: try members.string("description"),
            comment: try members.string("comment"),
            externalRefs: try members.values("externalRefs", ISO_5962.Package.Reference.init(json:)),
            attributionTexts: try members.strings("attributionTexts"),
            hasFiles: try members.values("hasFiles", ISO_5962.Identifier.init(json:)),
            annotations: try members.values("annotations", ISO_5962.Annotation.init(json:))
        )
    }

    static func text(_ json: RFC_8259.Value) throws(ISO_5962.Error) -> String {
        guard let text = json.string else { throw .malformed }
        return text
    }

    static func expression(_ json: RFC_8259.Value) throws(ISO_5962.Error) -> ISO_5962.Expression {
        guard let text = json.string else { throw .malformed }
        do throws(ISO_5962.Expression.Error) {
            return try ISO_5962.Expression(text)
        } catch {
            throw .malformed
        }
    }

    static func simple(_ json: RFC_8259.Value) throws(ISO_5962.Error) -> ISO_5962.Expression.Simple {
        guard let text = json.string else { throw .malformed }
        do throws(ISO_5962.Expression.Error) {
            return try ISO_5962.Expression.Simple(text)
        } catch {
            throw .malformed
        }
    }

    static func analysis(_ members: ISO_5962.Members) throws(ISO_5962.Error) -> ISO_5962.Package.Analysis {
        let verification = try members.value("packageVerificationCode", ISO_5962.Package.Verification.init(json:))
        guard try members.boolean("filesAnalyzed") == false else { return .analyzed(verification) }
        guard verification == nil else { throw .unexpected("packageVerificationCode") }
        return .unanalyzed
    }

    public var json: RFC_8259.Value {
        let filesAnalyzed: RFC_8259.Value
        let verification: RFC_8259.Value?
        switch analysis {
        case .analyzed(let code):
            filesAnalyzed = .bool(true)
            verification = code?.json
        case .unanalyzed:
            filesAnalyzed = .bool(false)
            verification = nil
        }
        return ISO_5962.Members.object([
            ("SPDXID", identifier.json),
            ("name", .string(name)),
            ("versionInfo", ISO_5962.Members.text(versionInfo)),
            ("packageFileName", ISO_5962.Members.text(fileName)),
            ("supplier", supplier?.json(\.json)),
            ("originator", originator?.json(\.json)),
            ("downloadLocation", ISO_5962.Members.asserted(downloadLocation)),
            ("filesAnalyzed", filesAnalyzed),
            ("packageVerificationCode", verification),
            ("checksums", ISO_5962.Members.array(checksums.map(\.json))),
            ("homepage", homepage.map(ISO_5962.Members.asserted)),
            ("sourceInfo", ISO_5962.Members.text(sourceInfo)),
            ("licenseConcluded", ISO_5962.Members.asserted(licenseConcluded)),
            ("licenseInfoFromFiles", ISO_5962.Members.array(licenseInfoFromFiles.map(ISO_5962.Members.asserted))),
            ("licenseDeclared", ISO_5962.Members.asserted(licenseDeclared)),
            ("licenseComments", ISO_5962.Members.text(licenseComments)),
            ("copyrightText", ISO_5962.Members.asserted(copyrightText)),
            ("summary", ISO_5962.Members.text(summary)),
            ("description", ISO_5962.Members.text(description)),
            ("comment", ISO_5962.Members.text(comment)),
            ("externalRefs", ISO_5962.Members.array(externalRefs.map(\.json))),
            ("attributionTexts", ISO_5962.Members.strings(attributionTexts)),
            ("hasFiles", ISO_5962.Members.array(hasFiles.map(\.json))),
            ("annotations", ISO_5962.Members.array(annotations.map(\.json))),
        ])
    }
}
