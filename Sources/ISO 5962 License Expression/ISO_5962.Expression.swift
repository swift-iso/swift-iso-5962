extension ISO_5962 {
    public indirect enum Expression: Sendable, Hashable {
        case simple(ISO_5962.Expression.Simple)
        case exception(ISO_5962.Expression.Simple, String)
        case conjunction(ISO_5962.Expression, ISO_5962.Expression)
        case disjunction(ISO_5962.Expression, ISO_5962.Expression)
    }
}
