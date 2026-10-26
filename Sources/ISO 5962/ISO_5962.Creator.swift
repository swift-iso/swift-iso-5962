extension ISO_5962 {
    public enum Creator: Sendable, Hashable {
        case person(String)
        case organization(String)
        case tool(String)
    }
}
