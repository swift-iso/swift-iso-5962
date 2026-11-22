public import Byte
public import ISO_5962_License_Expression

extension ISO.`5962` {
    public struct Checksum: Sendable, Hashable {
        public let algorithm: ISO.`5962`.Checksum.Algorithm
        public let value: [Byte]

        public init(algorithm: ISO.`5962`.Checksum.Algorithm, value: [Byte]) throws(ISO.`5962`.Error) {
            guard algorithm.lengths.contains(value.count) else { throw .invalid("checksumValue") }
            self.algorithm = algorithm
            self.value = value
        }
    }
}
