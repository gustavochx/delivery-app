// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Feature",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "FeaturesPack",
            targets: ["Home", "Restaurants"]
        ),
    ],
    dependencies: [
        .package(path: "../CoreLibrary"),
        .package(path: "../UILibrary"),
        // Development - Third Party
        .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.1.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.2.0"),
    ],
    targets: [
        // Home
        .target(
            name: "Home",
            dependencies: [
                // Feature
                "RestaurantsInterface",
                // Core
                .product(name: "Navigation", package: "CoreLibrary"),
                .swiftDependencies,
                // Interfaces
                .product(name: "ServicesInterface", package: "CoreLibrary"),
                // UI
                .product(name: "UIFoundations", package: "UILibrary"),
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]
        ),
        .target(
            name: "RestaurantsInterface",
            dependencies: [
                .product(name: "Navigation", package: "CoreLibrary"),
                .swiftDependencies,
            ]
        ),
        .target(
            name: "Restaurants",
            dependencies: [
                "RestaurantsInterface",
                .product(name: "UIFoundations", package: "UILibrary"),
            ]
        ),
        .testTarget(
            name: "RestaurantsTests",
            dependencies: ["Restaurants"]
        ),
    ]
)

// MARK: - Target Dependency Aliases
extension PackageDescription.Target.Dependency {
    // Development - Third Party
    static let swiftDependencies: Self = .product(name: "Dependencies", package: "swift-dependencies")
    static let xcTestDynamicOverlay: Self = .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay")
}
