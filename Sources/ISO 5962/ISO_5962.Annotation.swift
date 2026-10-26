public import ISO_8601

extension ISO_5962 {
    public struct Annotation: Sendable, Hashable {
        public let date: ISO_8601.DateTime
        public let kind: ISO_5962.Annotation.Kind
        public let annotator: ISO_5962.Creator
        public let comment: String

        public init(
            date: ISO_8601.DateTime,
            kind: ISO_5962.Annotation.Kind,
            annotator: ISO_5962.Creator,
            comment: String
        ) {
            self.date = date
            self.kind = kind
            self.annotator = annotator
            self.comment = comment
        }
    }
}
