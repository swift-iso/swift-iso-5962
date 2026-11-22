public import ISO_5962_License_Expression
public import ISO_8601

extension ISO.`5962` {
    public struct Annotation: Sendable, Hashable {
        public let date: ISO.`8601`.DateTime
        public let kind: ISO.`5962`.Annotation.Kind
        public let annotator: ISO.`5962`.Creator
        public let comment: String

        public init(
            date: ISO.`8601`.DateTime,
            kind: ISO.`5962`.Annotation.Kind,
            annotator: ISO.`5962`.Creator,
            comment: String
        ) {
            self.date = date
            self.kind = kind
            self.annotator = annotator
            self.comment = comment
        }
    }
}
