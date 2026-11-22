extension ISO.`5962`.Expression.Simple {
    static let documentRef = "DocumentRef-"

    static let licenseRef = "LicenseRef-"

    public init(_ token: some StringProtocol) throws(ISO.`5962`.Expression.Error) {
        let text = String(token)
        if text.hasPrefix(Self.documentRef) {
            let parts = text.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: false)
            let document = parts[0].dropFirst(Self.documentRef.count)
            guard parts.count == 2, ISO.`5962`.isIdstring(document), parts[1].hasPrefix(Self.licenseRef) else {
                throw .invalid(text)
            }
            self = try Self.referenced(parts[1].dropFirst(Self.licenseRef.count), document: String(document), text)
        } else if text.hasPrefix(Self.licenseRef) {
            self = try Self.referenced(text.dropFirst(Self.licenseRef.count), document: nil, text)
        } else if text.hasSuffix("+") {
            let id = text.dropLast()
            guard ISO.`5962`.isIdstring(id) else { throw .invalid(text) }
            self = .later(String(id))
        } else {
            guard ISO.`5962`.isIdstring(text) else { throw .invalid(text) }
            self = .license(text)
        }
    }

    static func referenced(
        _ id: Substring,
        document: String?,
        _ text: String
    ) throws(ISO.`5962`.Expression.Error) -> Self {
        guard ISO.`5962`.isIdstring(id) else { throw .invalid(text) }
        return .reference(String(id), document: document)
    }
}
