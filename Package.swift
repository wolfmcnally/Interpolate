// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Interpolate",
    products: [
        .library(
            name: "Interpolate",
            targets: ["Interpolate"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Interpolate",
            dependencies: []),
        .testTarget(
            name: "InterpolateTests",
            dependencies: ["Interpolate"]),
    ]
)
