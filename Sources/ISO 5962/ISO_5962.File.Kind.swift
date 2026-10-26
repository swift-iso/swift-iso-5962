public import ISO_5962_License_Expression

extension ISO_5962.File {
    public enum Kind: String, Sendable, Hashable, CaseIterable {
        case other = "OTHER"
        case documentation = "DOCUMENTATION"
        case image = "IMAGE"
        case video = "VIDEO"
        case archive = "ARCHIVE"
        case spdx = "SPDX"
        case application = "APPLICATION"
        case source = "SOURCE"
        case binary = "BINARY"
        case text = "TEXT"
        case audio = "AUDIO"
    }
}
