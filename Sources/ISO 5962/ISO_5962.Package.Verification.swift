public import Byte
public import ISO_5962_License_Expression

extension ISO_5962.Package {
    public struct Verification: Sendable, Hashable {
        public let value: [Byte]
        public let excluded: [String]

        public init(value: [Byte], excluded: [String] = []) throws(ISO_5962.Error) {
            guard ISO_5962.Checksum.Algorithm.sha1.lengths.contains(value.count) else {
                throw .invalid("packageVerificationCodeValue")
            }
            self.value = value
            self.excluded = excluded
        }
    }
}
