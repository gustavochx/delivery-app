// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FeatureModules",
            targets: ["Restaurants", "Home"]
        ),
        .library(
            name: "RestaurantsInterface",
            targets: ["RestaurantsInterface"]
        ),
        .library(
            name: "Home",
            targets: ["Home"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "./Core"),
        .package(name: "UI", path: "./UI")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RestaurantsInterface",
            dependencies: [
                .product(name: "Navigation", package: "Core")
            ]
        ),
        .target(
            name: "Restaurants",
            dependencies: [
                "RestaurantsInterface",
                .product(name: "Networking", package: "Core"),
                .product(name: "Navigation", package: "Core")
            ]
        ),
        .testTarget(
            name: "RestaurantsTests",
            dependencies: ["Restaurants"]
        ),
        .target(
            name: "Home",
            dependencies: [
                // Core
                .product(name: "Navigation", package: "Core"),
                .product(name: "ServicesInterface", package: "Core"),
                // UI
                .product(name: "UIFoundations", package: "UI"),
                // Features
                "RestaurantsInterface"
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: ["Home"]
        ),
    ]
)
