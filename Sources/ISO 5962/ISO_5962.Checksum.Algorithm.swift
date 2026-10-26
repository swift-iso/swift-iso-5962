extension ISO_5962.Checksum {
    public enum Algorithm: String, Sendable, Hashable, CaseIterable {
        case sha1 = "SHA1"
        case sha224 = "SHA224"
        case sha256 = "SHA256"
        case sha384 = "SHA384"
        case sha512 = "SHA512"
        case md2 = "MD2"
        case md4 = "MD4"
        case md5 = "MD5"
        case md6 = "MD6"
    }
}
