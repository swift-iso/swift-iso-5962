public import ISO_5962_License_Expression
import RFC_3986
public import RFC_8259

extension ISO_5962.Document {
    static let keys: Set<String> = [
        "SPDXID", "revieweds", "hasExtractedLicensingInfos", "name", "comment", "spdxVersion", "annotations",
        "dataLicense", "externalDocumentRefs", "creationInfo", "documentNamespace", "documentDescribes", "packages",
        "files", "snippets", "relationships",
    ]

    public static let version = "SPDX-2.2"

    public static let license = "CC0-1.0"

    static let identifier = "SPDXRef-DOCUMENT"

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let version = try members.string("spdxVersion") else { throw .missing("spdxVersion") }
        guard version == Self.version else { throw .invalid("spdxVersion") }
        guard let license = try members.string("dataLicense") else { throw .missing("dataLicense") }
        guard license == Self.license else { throw .invalid("dataLicense") }
        guard let identifier = try members.string("SPDXID") else { throw .missing("SPDXID") }
        guard identifier == Self.identifier else { throw .invalid("SPDXID") }
        guard let name = try members.string("name") else { throw .missing("name") }
        guard let namespace = try members.uri("documentNamespace") else { throw .missing("documentNamespace") }
        guard let creationInfo = try members.value("creationInfo", ISO_5962.Creation.init(json:)) else {
            throw .missing("creationInfo")
        }
        try self.init(
            name: name,
            namespace: namespace,
            creationInfo: creationInfo,
            comment: try members.string("comment"),
            externalDocumentRefs: try members.values("externalDocumentRefs", ISO_5962.Document.Reference.init(json:)),
            describes: try members.values("documentDescribes", ISO_5962.Identifier.init(json:)),
            packages: try members.values("packages", ISO_5962.Package.init(json:)),
            files: try members.values("files", ISO_5962.File.init(json:)),
            relationships: try members.values("relationships", ISO_5962.Relationship.init(json:)),
            hasExtractedLicensingInfos: try members.values("hasExtractedLicensingInfos", ISO_5962.License.init(json:)),
            annotations: try members.values("annotations", ISO_5962.Annotation.init(json:))
        )
    }

    public var json: RFC_8259.Value {
        ISO_5962.Members.object([
            ("spdxVersion", .string(Self.version)),
            ("dataLicense", .string(Self.license)),
            ("SPDXID", .string(Self.identifier)),
            ("name", .string(name)),
            ("documentNamespace", .string(namespace.value)),
            ("creationInfo", creationInfo.json),
            ("comment", ISO_5962.Members.text(comment)),
            ("externalDocumentRefs", ISO_5962.Members.array(externalDocumentRefs.map(\.json))),
            ("documentDescribes", ISO_5962.Members.array(describes.map(\.json))),
            ("packages", ISO_5962.Members.array(packages.map(\.json))),
            ("files", ISO_5962.Members.array(files.map(\.json))),
            ("relationships", ISO_5962.Members.array(relationships.map(\.json))),
            ("hasExtractedLicensingInfos", ISO_5962.Members.array(hasExtractedLicensingInfos.map(\.json))),
            ("annotations", ISO_5962.Members.array(annotations.map(\.json))),
        ])
    }
}
