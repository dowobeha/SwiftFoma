// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Foma",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Foma",
            targets: ["Foma"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/dowobeha/CFoma.git" /* package url */, from: "0.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Foma",
            dependencies: ["CFoma"]),
        .target(
            name: "demo",
            dependencies: ["Foma"]),
        .testTarget(
            name: "FomaTests",
            dependencies: ["Foma"]),
    ]
)
