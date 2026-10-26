extension ISO_5962.Expression {
    public enum Simple: Sendable, Hashable {
        case license(String)
        case later(String)
        case reference(String, document: String?)
    }
}
