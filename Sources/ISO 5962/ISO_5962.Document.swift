public import ISO_5962_License_Expression
public import RFC_3986

extension ISO_5962 {
    public struct Document: Sendable, Hashable {
        public let name: String
        public let namespace: RFC_3986.URI
        public let creationInfo: ISO_5962.Creation
        public let comment: String?
        public let externalDocumentRefs: [ISO_5962.Document.Reference]
        public let describes: [ISO_5962.Identifier]
        public let packages: [ISO_5962.Package]
        public let files: [ISO_5962.File]
        public let relationships: [ISO_5962.Relationship]
        public let hasExtractedLicensingInfos: [ISO_5962.License]
        public let annotations: [ISO_5962.Annotation]

        public init(
            name: String,
            namespace: RFC_3986.URI,
            creationInfo: ISO_5962.Creation,
            comment: String? = nil,
            externalDocumentRefs: [ISO_5962.Document.Reference] = [],
            describes: [ISO_5962.Identifier] = [],
            packages: [ISO_5962.Package] = [],
            files: [ISO_5962.File] = [],
            relationships: [ISO_5962.Relationship] = [],
            hasExtractedLicensingInfos: [ISO_5962.License] = [],
            annotations: [ISO_5962.Annotation] = []
        ) throws(ISO_5962.Error) {
            guard !namespace.isRelative, namespace.fragment == nil else { throw .invalid("documentNamespace") }
            self.name = name
            self.namespace = namespace
            self.creationInfo = creationInfo
            self.comment = comment
            self.externalDocumentRefs = externalDocumentRefs
            self.describes = describes
            self.packages = packages
            self.files = files
            self.relationships = relationships
            self.hasExtractedLicensingInfos = hasExtractedLicensingInfos
            self.annotations = annotations
        }
    }
}
