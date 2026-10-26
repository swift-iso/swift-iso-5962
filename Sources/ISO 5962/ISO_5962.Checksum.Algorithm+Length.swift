public import ISO_5962_License_Expression

extension ISO_5962.Checksum.Algorithm {
    var lengths: ClosedRange<Int> {
        switch self {
        case .sha1: 20...20
        case .sha224: 28...28
        case .sha256: 32...32
        case .sha384: 48...48
        case .sha512: 64...64
        case .md2, .md4, .md5: 16...16
        case .md6: 1...64
        }
    }
}
