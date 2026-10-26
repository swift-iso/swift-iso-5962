// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-iso-5962",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "ISO 5962", targets: ["ISO 5962"]),
        .library(name: "ISO 5962 License Expression", targets: ["ISO 5962 License Expression"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-ietf/swift-rfc-8259.git", branch: "main"),
        .package(url: "https://github.com/swift-iso/swift-iso-8601.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-3986.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-binary.git", branch: "main", traits: ["Base"]),
        .package(url: "https://github.com/swift-atoms/swift-byte.git", branch: "main"),
        .package(url: "https://github.com/swift-ecma/swift-ecma-427.git", branch: "main"),
    ],
    targets: [
        .target(name: "ISO 5962 License Expression"),
        .target(
            name: "ISO 5962",
            dependencies: [
                .target(name: "ISO 5962 License Expression"),
                .product(name: "RFC 8259", package: "swift-rfc-8259"),
                .product(name: "ISO 8601", package: "swift-iso-8601"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "Binary", package: "swift-binary"),
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "ECMA 427", package: "swift-ecma-427"),
            ]
        ),
        .testTarget(
            name: "ISO 5962 License Expression Tests",
            dependencies: [
                .target(name: "ISO 5962 License Expression")
            ],
            path: "Tests/ISO 5962 License Expression Tests"
        ),
        .testTarget(
            name: "ISO 5962 Tests",
            dependencies: [
                .target(name: "ISO 5962"),
                .target(name: "ISO 5962 License Expression"),
                .product(name: "RFC 8259", package: "swift-rfc-8259"),
                .product(name: "RFC 3986", package: "swift-rfc-3986"),
                .product(name: "Byte", package: "swift-byte"),
            ],
            path: "Tests/ISO 5962 Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableExperimentalFeature("Lifetimes"),
            .treatAllWarnings(as: .error),
        ]
}
