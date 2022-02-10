// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NnUIKitHelpers",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "NnUIKitHelpers",
            targets: ["NnUIKitHelpers"]),
        .library(
            name: "UIKitDesigns",
            targets: ["UIKitDesigns"]),
        .library(
            name: "UIKitExtensions",
            targets: ["UIKitExtensions"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "NnUIKitHelpers",
            dependencies: []),
        .target(
            name: "UIKitDesigns",
            dependencies: ["UIKitExtensions"]),
        .target(
            name: "UIKitExtensions",
            dependencies: []),
        .testTarget(
            name: "NnUIKitHelpersTests",
            dependencies: ["NnUIKitHelpers"]),
    ]
)
