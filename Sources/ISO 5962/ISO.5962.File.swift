public import ISO_5962_License_Expression

extension ISO.`5962` {
    public struct File: Sendable, Hashable {
        public let identifier: ISO.`5962`.Identifier
        public let name: String
        public let types: [ISO.`5962`.File.Kind]
        public let checksums: [ISO.`5962`.Checksum]
        public let licenseConcluded: ISO.`5962`.Assertion<ISO.`5962`.Expression>
        public let licenseInfoInFiles: [ISO.`5962`.Assertion<ISO.`5962`.Expression.Simple>]
        public let licenseComments: String?
        public let copyrightText: ISO.`5962`.Assertion<String>
        public let comment: String?
        public let noticeText: String?
        public let contributors: [String]
        public let attributionTexts: [String]
        public let annotations: [ISO.`5962`.Annotation]

        public init(
            identifier: ISO.`5962`.Identifier,
            name: String,
            types: [ISO.`5962`.File.Kind] = [],
            checksums: [ISO.`5962`.Checksum],
            licenseConcluded: ISO.`5962`.Assertion<ISO.`5962`.Expression>,
            licenseInfoInFiles: [ISO.`5962`.Assertion<ISO.`5962`.Expression.Simple>],
            licenseComments: String? = nil,
            copyrightText: ISO.`5962`.Assertion<String>,
            comment: String? = nil,
            noticeText: String? = nil,
            contributors: [String] = [],
            attributionTexts: [String] = [],
            annotations: [ISO.`5962`.Annotation] = []
        ) throws(ISO.`5962`.Error) {
            guard !checksums.isEmpty else { throw .missing("checksums") }
            guard !licenseInfoInFiles.isEmpty else { throw .missing("licenseInfoInFiles") }
            self.identifier = identifier
            self.name = name
            self.types = types
            self.checksums = checksums
            self.licenseConcluded = licenseConcluded
            self.licenseInfoInFiles = licenseInfoInFiles
            self.licenseComments = licenseComments
            self.copyrightText = copyrightText
            self.comment = comment
            self.noticeText = noticeText
            self.contributors = contributors
            self.attributionTexts = attributionTexts
            self.annotations = annotations
        }
    }
}
