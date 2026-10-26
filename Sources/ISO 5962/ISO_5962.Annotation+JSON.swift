public import ISO_5962_License_Expression
import ISO_8601
public import RFC_8259

extension ISO_5962.Annotation {
    static let keys: Set<String> = ["annotationDate", "comment", "annotator", "annotationType"]

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        let members = try ISO_5962.Members(json, known: Self.keys)
        guard let date = try members.value("annotationDate", ISO_5962.Creation.time) else { throw .missing("annotationDate") }
        guard let kind = try members.value("annotationType", Kind.init(json:)) else { throw .missing("annotationType") }
        guard let annotator = try members.value("annotator", ISO_5962.Creator.init(json:)) else { throw .missing("annotator") }
        guard let comment = try members.string("comment") else { throw .missing("comment") }
        self.init(date: date, kind: kind, annotator: annotator, comment: comment)
    }

    public var json: RFC_8259.Value {
        ISO_5962.Members.object([
            ("annotationDate", .string(date.description)),
            ("annotationType", kind.json),
            ("annotator", annotator.json),
            ("comment", .string(comment)),
        ])
    }
}
