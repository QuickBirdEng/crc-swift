// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "CRC",
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
