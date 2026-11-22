extension ISO.`5962`.Expression.Simple: CustomStringConvertible {
    public var description: String {
        switch self {
        case .license(let id): id
        case .later(let id): id + "+"
        case .reference(let id, let document):
            (document.map { ISO.`5962`.Expression.Simple.documentRef + $0 + ":" } ?? "") + ISO.`5962`.Expression.Simple.licenseRef + id
        }
    }
}
