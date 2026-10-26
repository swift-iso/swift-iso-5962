extension ISO_5962.Expression.Simple: CustomStringConvertible {
    public var description: String {
        switch self {
        case .license(let id): id
        case .later(let id): id + "+"
        case .reference(let id, let document):
            (document.map { ISO_5962.Expression.Simple.documentRef + $0 + ":" } ?? "") + ISO_5962.Expression.Simple.licenseRef + id
        }
    }
}
