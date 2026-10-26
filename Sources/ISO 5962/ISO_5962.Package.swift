public import RFC_3986

extension ISO_5962 {
    public struct Package: Sendable, Hashable {
        public let identifier: ISO_5962.Identifier
        public let name: String
        public let versionInfo: String?
        public let fileName: String?
        public let supplier: ISO_5962.Assertion<ISO_5962.Creator>?
        public let originator: ISO_5962.Assertion<ISO_5962.Creator>?
        public let downloadLocation: ISO_5962.Assertion<RFC_3986.URI>
        public let analysis: ISO_5962.Package.Analysis
        public let checksums: [ISO_5962.Checksum]
        public let homepage: ISO_5962.Assertion<RFC_3986.URI>?
        public let sourceInfo: String?
        public let licenseConcluded: ISO_5962.Assertion<String>
        public let licenseInfoFromFiles: [ISO_5962.Assertion<String>]
        public let licenseDeclared: ISO_5962.Assertion<String>
        public let licenseComments: String?
        public let copyrightText: ISO_5962.Assertion<String>
        public let summary: String?
        public let description: String?
        public let comment: String?
        public let externalRefs: [ISO_5962.Package.Reference]
        public let attributionTexts: [String]
        public let hasFiles: [ISO_5962.Identifier]
        public let annotations: [ISO_5962.Annotation]

        public init(
            identifier: ISO_5962.Identifier,
            name: String,
            versionInfo: String? = nil,
            fileName: String? = nil,
            supplier: ISO_5962.Assertion<ISO_5962.Creator>? = nil,
            originator: ISO_5962.Assertion<ISO_5962.Creator>? = nil,
            downloadLocation: ISO_5962.Assertion<RFC_3986.URI>,
            analysis: ISO_5962.Package.Analysis = .analyzed(nil),
            checksums: [ISO_5962.Checksum] = [],
            homepage: ISO_5962.Assertion<RFC_3986.URI>? = nil,
            sourceInfo: String? = nil,
            licenseConcluded: ISO_5962.Assertion<String>,
            licenseInfoFromFiles: [ISO_5962.Assertion<String>] = [],
            licenseDeclared: ISO_5962.Assertion<String>,
            licenseComments: String? = nil,
            copyrightText: ISO_5962.Assertion<String>,
            summary: String? = nil,
            description: String? = nil,
            comment: String? = nil,
            externalRefs: [ISO_5962.Package.Reference] = [],
            attributionTexts: [String] = [],
            hasFiles: [ISO_5962.Identifier] = [],
            annotations: [ISO_5962.Annotation] = []
        ) {
            self.identifier = identifier
            self.name = name
            self.versionInfo = versionInfo
            self.fileName = fileName
            self.supplier = supplier
            self.originator = originator
            self.downloadLocation = downloadLocation
            self.analysis = analysis
            self.checksums = checksums
            self.homepage = homepage
            self.sourceInfo = sourceInfo
            self.licenseConcluded = licenseConcluded
            self.licenseInfoFromFiles = licenseInfoFromFiles
            self.licenseDeclared = licenseDeclared
            self.licenseComments = licenseComments
            self.copyrightText = copyrightText
            self.summary = summary
            self.description = description
            self.comment = comment
            self.externalRefs = externalRefs
            self.attributionTexts = attributionTexts
            self.hasFiles = hasFiles
            self.annotations = annotations
        }
    }
}
