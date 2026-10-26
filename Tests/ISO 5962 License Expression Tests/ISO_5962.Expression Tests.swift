import ISO_5962_License_Expression
import Testing

extension ISO_5962.Expression {
    @Suite struct Test {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
    }
}

extension ISO_5962.Expression.Test.Unit {

    @Test(arguments: [
        "MIT",
        "GPL-2.0+",
        "LicenseRef-3",
        "DocumentRef-spdx-tool-1.2:LicenseRef-MIT-Style-2",
        "LGPL-2.0-only OR LicenseRef-3",
        "EPL-2.0 OR GPL-2.0 WITH Classpath-exception-2.0",
        "a AND (b AND c)",
        "(a OR b) AND c",
        "a OR b AND c",
    ])
    func `a canonical expression prints as written and reads back equal`(text: String) throws {
        let expression = try ISO_5962.Expression(text)
        #expect(expression.description == text)
        #expect(try ISO_5962.Expression(expression.description) == expression)
    }

    @Test
    func `simple expressions are licenses, later versions and references`() throws {
        #expect(try ISO_5962.Expression("MIT") == .simple(.license("MIT")))
        #expect(try ISO_5962.Expression("GPL-2.0+") == .simple(.later("GPL-2.0")))
        #expect(try ISO_5962.Expression("LicenseRef-3") == .simple(.reference("3", document: nil)))
        #expect(
            try ISO_5962.Expression("DocumentRef-spdx-tool-1.2:LicenseRef-MIT-Style-2")
                == .simple(.reference("MIT-Style-2", document: "spdx-tool-1.2"))
        )
    }

    @Test
    func `WITH binds tighter than AND, and AND tighter than OR`() throws {
        let expression = try ISO_5962.Expression("a OR b AND c WITH e")
        #expect(expression == .disjunction(.simple(.license("a")), .conjunction(.simple(.license("b")), .exception(.license("c"), "e"))))
    }

    @Test
    func `parentheses override precedence and redundant ones are dropped`() throws {
        #expect(try ISO_5962.Expression("(a OR b) AND c") == .conjunction(.disjunction(.simple(.license("a")), .simple(.license("b"))), .simple(.license("c"))))
        #expect(try ISO_5962.Expression("((LGPL-2.0-only OR LicenseRef-3))").description == "LGPL-2.0-only OR LicenseRef-3")
    }
}

extension ISO_5962.Expression.Test.`Edge Case` {

    @Test(arguments: ["", "MIT AND", "(MIT", "MIT WITH", "a OR"])
    func `an expression that ends early is incomplete`(text: String) {
        #expect(throws: ISO_5962.Expression.Error.incomplete) { try ISO_5962.Expression(text) }
    }

    @Test
    func `operators are case-sensitive`() {
        #expect(throws: ISO_5962.Expression.Error.unexpected("and")) { try ISO_5962.Expression("a and b") }
    }

    @Test
    func `stray tokens are unexpected`() {
        #expect(throws: ISO_5962.Expression.Error.unexpected(")")) { try ISO_5962.Expression("MIT)") }
        #expect(throws: ISO_5962.Expression.Error.unexpected("b")) { try ISO_5962.Expression("a b") }
        #expect(throws: ISO_5962.Expression.Error.unexpected("AND")) { try ISO_5962.Expression("AND MIT") }
    }

    @Test
    func `there is no white space before the plus`() {
        #expect(throws: ISO_5962.Expression.Error.unexpected("+")) { try ISO_5962.Expression("GPL-2.0 +") }
    }

    @Test
    func `identifiers must be idstrings`() {
        #expect(throws: ISO_5962.Expression.Error.invalid("LicenseRef-")) { try ISO_5962.Expression("LicenseRef-") }
        #expect(throws: ISO_5962.Expression.Error.invalid("DocumentRef-x")) { try ISO_5962.Expression("DocumentRef-x") }
        #expect(throws: ISO_5962.Expression.Error.invalid("M_T")) { try ISO_5962.Expression("M_T") }
    }

    @Test
    func `an exception follows only a simple expression`() {
        #expect(throws: ISO_5962.Expression.Error.unexpected("WITH")) { try ISO_5962.Expression("(a OR b) WITH e") }
    }
}
