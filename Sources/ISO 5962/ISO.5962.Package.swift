public import ISO_5962_License_Expression
public import RFC_3986

extension ISO.`5962` {
    public struct Package: Sendable, Hashable {
        public let identifier: ISO.`5962`.Identifier
        public let name: String
        public let versionInfo: String?
        // swift-linter:disable:next raw concept
        // REASON: SPDX's packageFileName, the package's file name or a relative directory path as the document's author wrote it, not a path on this file system; looked at Path and Path.Component, which hold this platform's names and aren't among this package's dependencies.
        public let fileName: String?
        public let supplier: ISO.`5962`.Assertion<ISO.`5962`.Creator>?
        public let originator: ISO.`5962`.Assertion<ISO.`5962`.Creator>?
        public let downloadLocation: ISO.`5962`.Assertion<RFC_3986.URI>
        public let analysis: ISO.`5962`.Package.Analysis
        public let checksums: [ISO.`5962`.Checksum]
        public let homepage: ISO.`5962`.Assertion<RFC_3986.URI>?
        public let sourceInfo: String?
        public let licenseConcluded: ISO.`5962`.Assertion<ISO.`5962`.Expression>
        public let licenseInfoFromFiles: [ISO.`5962`.Assertion<ISO.`5962`.Expression.Simple>]
        public let licenseDeclared: ISO.`5962`.Assertion<ISO.`5962`.Expression>
        public let licenseComments: String?
        public let copyrightText: ISO.`5962`.Assertion<String>
        public let summary: String?
        public let description: String?
        public let comment: String?
        public let externalRefs: [ISO.`5962`.Package.Reference]
        public let attributionTexts: [String]
        public let hasFiles: [ISO.`5962`.Identifier]
        public let annotations: [ISO.`5962`.Annotation]

        public init(
            identifier: ISO.`5962`.Identifier,
            name: String,
            versionInfo: String? = nil,
            // swift-linter:disable:next raw concept
            // REASON: SPDX's packageFileName, the package's file name or a relative directory path as the document's author wrote it, not a path on this file system; looked at Path and Path.Component, which hold this platform's names and aren't among this package's dependencies.
            fileName: String? = nil,
            supplier: ISO.`5962`.Assertion<ISO.`5962`.Creator>? = nil,
            originator: ISO.`5962`.Assertion<ISO.`5962`.Creator>? = nil,
            downloadLocation: ISO.`5962`.Assertion<RFC_3986.URI>,
            analysis: ISO.`5962`.Package.Analysis = .analyzed(nil),
            checksums: [ISO.`5962`.Checksum] = [],
            homepage: ISO.`5962`.Assertion<RFC_3986.URI>? = nil,
            sourceInfo: String? = nil,
            licenseConcluded: ISO.`5962`.Assertion<ISO.`5962`.Expression>,
            licenseInfoFromFiles: [ISO.`5962`.Assertion<ISO.`5962`.Expression.Simple>] = [],
            licenseDeclared: ISO.`5962`.Assertion<ISO.`5962`.Expression>,
            licenseComments: String? = nil,
            copyrightText: ISO.`5962`.Assertion<String>,
            summary: String? = nil,
            description: String? = nil,
            comment: String? = nil,
            externalRefs: [ISO.`5962`.Package.Reference] = [],
            attributionTexts: [String] = [],
            hasFiles: [ISO.`5962`.Identifier] = [],
            annotations: [ISO.`5962`.Annotation] = []
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
