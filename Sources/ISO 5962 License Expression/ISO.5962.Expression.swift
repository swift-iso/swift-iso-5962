extension ISO.`5962` {
    public indirect enum Expression: Sendable, Hashable {
        case simple(ISO.`5962`.Expression.Simple)
        case exception(ISO.`5962`.Expression.Simple, String)
        case conjunction(ISO.`5962`.Expression, ISO.`5962`.Expression)
        case disjunction(ISO.`5962`.Expression, ISO.`5962`.Expression)
    }
}
