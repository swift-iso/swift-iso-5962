extension ISO_5962 {
    public enum Assertion<Value> {
        case value(Value)
        case absent
        case unasserted
    }
}

extension ISO_5962.Assertion: Sendable where Value: Sendable {}

extension ISO_5962.Assertion: Equatable where Value: Equatable {}

extension ISO_5962.Assertion: Hashable where Value: Hashable {}
