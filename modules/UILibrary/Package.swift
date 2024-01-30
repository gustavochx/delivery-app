// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UILibrary",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "UIFoundations",
            targets: ["UIFoundations"]),
        // TODO: Discuss a better naming with Bocato
        .library(name: "SwiftUIComponents",
                 targets: ["SwiftUIComponents"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "UIFoundations",
            dependencies: []),
        .testTarget(
            name: "UIFoundationsTests",
            dependencies: ["UIFoundations"]),
        .target(
            name: "SwiftUIComponents",
            dependencies: [])
    ]
)
