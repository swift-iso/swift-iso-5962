extension ISO_5962 {
    public static func isIdstring(_ text: some StringProtocol) -> Bool {
        !text.isEmpty && text.allSatisfy { $0.isASCII && ($0.isLetter || $0.isNumber || $0 == "-" || $0 == ".") }
    }
}
