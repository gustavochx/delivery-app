// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UILibrary",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "UIFoundations",
            targets: ["UIFoundations"]
        ),
        .library(
            name: "SwiftUIFoundations",
            targets: ["SwiftUIFoundations"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UIFoundations",
            dependencies: []
        ),
        .testTarget(
            name: "UIFoundationsTests",
            dependencies: ["UIFoundations"]
        ),
        .target(
            name: "SwiftUIFoundations",
            dependencies: []
        )
    ]
)
