// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SlidingTabView",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SlidingTabView",
            targets: ["SlidingTabView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/GeorgeElsham/ViewExtractor", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SlidingTabView",
            dependencies: ["ViewExtractor"],
            path: "Sources"),
        .testTarget(
            name: "SlidingTabViewTests",
            dependencies: ["SlidingTabView"]),
    ]
)
