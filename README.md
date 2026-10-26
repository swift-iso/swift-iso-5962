# swift-iso-5962

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Swift implementation of ISO/IEC 5962:2021, the SPDX specification V2.2.1.

## Overview

ISO/IEC 5962:2021 is SPDX 2.2.1, a format for software bills of materials (SBOMs). This package models its JSON serialization: the document and its creation information, packages, files, relationships, annotations, extracted licensing information and references to other SPDX documents. Each type reads from and writes to an `RFC_8259.Value`, and reading refuses what the SPDX 2.2 JSON schema refuses, plus what the specification text makes mandatory without condition: a document must declare `SPDX-2.2`, `CC0-1.0` and `SPDXRef-DOCUMENT`, carry a namespace URI without a fragment, and name at least one creator.

```swift
import ISO_5962

let document = try ISO_5962.Document(json: value)
document.creationInfo.created            // ISO_8601.DateTime, in UTC
document.packages.first?.downloadLocation // .value(RFC_3986.URI), .absent (NONE) or .unasserted (NOASSERTION)
document.relationships.first?.kind        // ISO_5962.Relationship.Kind
try ISO_5962.Document(json: document.json) == document
```

`ISO_5962.Assertion` carries the specification's special values: `.absent` is `NONE` and `.unasserted` is `NOASSERTION`. Checksums are bytes checked against their algorithm's length, so a `FIPS_180_4.Digest`'s `bytes` can be used as an `ISO_5962.Checksum`'s value directly.

## What is left out

Snippets, the deprecated reviewer information, file `artifactOfs` and `fileDependencies`, and the cross-references of extracted licenses are accepted and dropped when read. A verification code is not required when files were analyzed, and a file is not required to carry a SHA1 checksum, although the specification text asks for both.

License expressions, license identifiers and package URLs are kept as text: the SPDX license expression grammar (Annex D) and the SPDX license list are not modelled here, and neither is the package URL grammar of ECMA-427.

## Later editions

SPDX 2.3 and 3.0 are not ISO editions yet; SPDX 3.0 is at the DIS stage as the next edition of ISO/IEC 5962. SPDX 2.3 keeps this JSON shape but makes the license and copyright members of packages and files optional, adds a package's primary purpose and its release, build and valid-until dates, adds checksum algorithms (SHA3, BLAKE2b, BLAKE3, ADLER32) and relationship types (`AMENDS`, `REQUIREMENT_DESCRIPTION_FOR`, `SPECIFICATION_FOR`), and spells the external reference categories `PACKAGE-MANAGER` and `PERSISTENT-ID` where the 2.2 JSON schema has `PACKAGE_MANAGER` and no persistent identifiers. This package refuses a `SPDX-2.3` document. SPDX 3.0 replaces the document with a JSON-LD graph of elements organised in profiles and shares no JSON shape with 2.2.

The tests transliterate the SPDX 2.2 JSON example from the SPDX specification repository (CC-BY-3.0).

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
