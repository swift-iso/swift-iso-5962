public import ISO_5962_License_Expression
public import RFC_8259

extension ISO_5962.Identifier {
    static let prefix = "SPDXRef-"

    static let reference = "DocumentRef-"

    public init(json: RFC_8259.Value) throws(ISO_5962.Error) {
        guard let text = json.string else { throw .malformed }
        let parts = text.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: false)
        let document: String?
        let element: Substring
        if parts.count == 2 {
            guard parts[0].hasPrefix(Self.reference) else { throw .malformed }
            document = String(parts[0].dropFirst(Self.reference.count))
            element = parts[1]
        } else {
            document = nil
            element = parts[0]
        }
        guard element.hasPrefix(Self.prefix) else { throw .malformed }
        do throws(ISO_5962.Error) {
            try self.init(String(element.dropFirst(Self.prefix.count)), document: document)
        } catch {
            throw .malformed
        }
    }

    public var json: RFC_8259.Value { .string(description) }
}
