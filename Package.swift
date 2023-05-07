// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "KeccakSwift",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "KeccakSwift", targets: ["KeccakSwift"]),
        .library(name: "KeccakC", targets: ["KeccakC"])
    ],
    targets: [
        .target(
            name: "KeccakSwift",
            dependencies: ["KeccakC"]
        ),
        .target(name: "KeccakC")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)

