# swift-iso-5962

Use this package when you need to read or write a software bill of materials in SPDX 2.2 JSON, the edition published as ISO/IEC 5962:2021. Start from `ISO_5962.Document`, which reads from and writes to an `RFC_8259.Value`; turn JSON text into that value with swift-json. If you only need SPDX license expressions, for example inside a CycloneDX document, use the `ISO 5962 License Expression` product and start from `ISO_5962.Expression`.

## Laws

- Only SPDX 2.2 is read. A document must declare `SPDX-2.2`, the data license `CC0-1.0` and the identifier `SPDXRef-DOCUMENT`, and these are written back unchanged. A `SPDX-2.3` document is refused.
- A member the SPDX 2.2 JSON schema doesn't define is refused. Snippets, reviewers, a file's `artifactOfs` and `fileDependencies`, and an extracted license's `crossRefs` are accepted and dropped.
- The document namespace must be an absolute URI without a fragment. Creation needs at least one creator, and its time must be in UTC.
- The strings `NONE` and `NOASSERTION` read as `ISO_5962.Assertion.absent` and `ISO_5962.Assertion.unasserted`, and are written back the same way.
- A creator is written `Person: `, `Organization: ` or `Tool: ` followed by the name. Spaces after the colon are dropped on reading. A tool can't be a package's supplier or originator.
- An element identifier is `SPDXRef-` followed by an idstring, optionally after `DocumentRef-` and an idstring and a colon. An idstring is one or more ASCII letters, digits, `-` and `.`.
- Checksum values are hexadecimal, read in either case and written in lowercase. A value must have its algorithm's length, for example 20 bytes for SHA1. MD6 allows 1 to 64 bytes. A package verification code is 20 bytes.
- A package with no `filesAnalyzed` counts as analyzed. An unanalyzed package with a verification code is refused. An analyzed package doesn't need a verification code.
- A file needs at least one checksum, of any algorithm, and at least one license information entry.
- A package-manager reference of type `purl` must parse as a package URL. Other reference types keep their locator as text.
- Empty arrays and absent optional members are left out when writing.
- In a license expression, `WITH` binds tighter than `AND`, and `AND` tighter than `OR`. Operators must be upper case. Writing an expression adds parentheses only where precedence needs them, so redundant ones are dropped.
- The `+` for later versions follows the identifier with no space. An exception after `WITH` must be an idstring, and `WITH` may only follow a simple expression.
- License identifiers are checked against the idstring grammar, not against the SPDX license list, and compare exactly, case included.
