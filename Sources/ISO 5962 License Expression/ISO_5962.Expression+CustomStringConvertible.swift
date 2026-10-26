extension ISO_5962.Expression: CustomStringConvertible {
    public var description: String {
        switch self {
        case .simple(let simple): simple.description
        case .exception(let simple, let exception): simple.description + " WITH " + exception
        case .conjunction(let left, let right): left.operand(above: 1) + " AND " + right.operand(above: 2)
        case .disjunction(let left, let right): left.operand(above: 0) + " OR " + right.operand(above: 1)
        }
    }

    var precedence: Int {
        switch self {
        case .disjunction: 0
        case .conjunction: 1
        case .simple, .exception: 2
        }
    }

    func operand(above minimum: Int) -> String {
        precedence >= minimum ? description : "(" + description + ")"
    }
}
