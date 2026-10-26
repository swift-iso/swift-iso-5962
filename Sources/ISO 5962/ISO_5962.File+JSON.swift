public import RFC_8259

extension ISO_5962.File {
    static let keys: Set<String> = [
        "SPDXID", "fileTypes", "attributionTexts", "annotations", "checksums", "noticeText", "artifactOfs",
        "licenseComments", "fileName", "comment", "copyrightText", "fileContributors", "licenseInfoInFiles",
        "licenseConcluded", "fileDependencies",
    ]

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let identifier = try members.value("SPDXID", ISO_5962.Identifier.init(json:)) else { throw .missing("SPDXID") }
        guard let name = try members.string("fileName") else { throw .missing("fileName") }
        guard let licenseConcluded = try members.assertion("licenseConcluded", ISO_5962.Package.expression) else {
            throw .missing("licenseConcluded")
        }
        guard let copyrightText = try members.assertion("copyrightText", ISO_5962.Package.expression) else {
            throw .missing("copyrightText")
        }
        try self.init(
            identifier: identifier,
            name: name,
            types: try members.values("fileTypes", Kind.init(json:)),
            checksums: try members.values("checksums", ISO_5962.Checksum.init(json:)),
            licenseConcluded: licenseConcluded,
            licenseInfoInFiles: try members.assertions("licenseInfoInFiles", ISO_5962.Package.expression),
            licenseComments: try members.string("licenseComments"),
            copyrightText: copyrightText,
            comment: try members.string("comment"),
            noticeText: try members.string("noticeText"),
            contributors: try members.strings("fileContributors"),
            attributionTexts: try members.strings("attributionTexts"),
            annotations: try members.values("annotations", ISO_5962.Annotation.init(json:))
        )
    }

    public var json: RFC_8259.Value {
        ISO_5962.Members.object([
            ("SPDXID", identifier.json),
            ("fileName", .string(name)),
            ("fileTypes", ISO_5962.Members.array(types.map(\.json))),
            ("checksums", ISO_5962.Members.array(checksums.map(\.json))),
            ("licenseConcluded", ISO_5962.Members.asserted(licenseConcluded)),
            ("licenseInfoInFiles", ISO_5962.Members.array(licenseInfoInFiles.map(ISO_5962.Members.asserted))),
            ("licenseComments", ISO_5962.Members.text(licenseComments)),
            ("copyrightText", ISO_5962.Members.asserted(copyrightText)),
            ("comment", ISO_5962.Members.text(comment)),
            ("noticeText", ISO_5962.Members.text(noticeText)),
            ("fileContributors", ISO_5962.Members.strings(contributors)),
            ("attributionTexts", ISO_5962.Members.strings(attributionTexts)),
            ("annotations", ISO_5962.Members.array(annotations.map(\.json))),
        ])
    }
}
