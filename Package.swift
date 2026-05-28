// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "CRC",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(
            name: "CRC",
            targets: ["CRC"]
        ),
    ],
    targets: [
        .target(
            name: "CRC",
            path: "Sources"
        ),
        .testTarget(
            name: "CRCTests",
            dependencies: ["CRC"],
            path: "Tests"
        ),
    ]
)
