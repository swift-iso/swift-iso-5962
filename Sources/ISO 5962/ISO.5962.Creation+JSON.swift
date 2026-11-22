public import ISO_5962_License_Expression
import ISO_8601
public import RFC_8259

extension ISO.`5962`.Creation {
    static let keys: Set<String> = ["comment", "created", "creators", "licenseListVersion"]

    public init(json: RFC_8259.Value) throws(ISO.`5962`.Error) {
        let members = try ISO.`5962`.Members(json, known: Self.keys)
        guard let created = try members.value("created", Self.time) else { throw .missing("created") }
        try self.init(
            created: created,
            creators: try members.values("creators", ISO.`5962`.Creator.init(json:)),
            licenseListVersion: try members.string("licenseListVersion"),
            comment: try members.string("comment")
        )
    }

    static func time(_ json: RFC_8259.Value) throws(ISO.`5962`.Error) -> ISO.`8601`.DateTime {
        guard let text = json.string else { throw .malformed }
        let time: ISO.`8601`.DateTime
        do throws(ISO.`8601`.DateTime.Parser.Error) {
            time = try ISO.`8601`.DateTime(text)
        } catch {
            throw .malformed
        }
        guard time.offset == .utc else { throw .malformed }
        return time
    }

    public var json: RFC_8259.Value {
        ISO.`5962`.Members.object([
            ("comment", ISO.`5962`.Members.text(comment)),
            ("created", .string(created.description)),
            ("creators", ISO.`5962`.Members.array(creators.map(\.json))),
            ("licenseListVersion", ISO.`5962`.Members.text(licenseListVersion)),
        ])
    }
}
