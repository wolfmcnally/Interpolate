// swift-tools-version:5.6
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
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Interpolate",
            dependencies: [
                .product(name: "Numerics", package: "swift-numerics")
            ]),
        .testTarget(
            name: "InterpolateTests",
            dependencies: ["Interpolate"]),
    ]
)
