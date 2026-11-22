public import ISO_5962_License_Expression

extension ISO.`5962` {
    public enum Assertion<Value> {
        case value(Value)
        case absent
        case unasserted
    }
}

extension ISO.`5962`.Assertion: Sendable where Value: Sendable {}

extension ISO.`5962`.Assertion: Equatable where Value: Equatable {}

extension ISO.`5962`.Assertion: Hashable where Value: Hashable {}
