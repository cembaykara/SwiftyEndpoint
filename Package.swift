// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyEndpoint",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftyEndpoint",
            targets: ["SwiftyEndpoint"]),
		.library(
			name: "SwiftyExamples",
			targets: ["SwiftyExamples"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
			name: "SwiftyEndpoint",
			path: "SwiftyEndpoint"),
		.target(
			name: "SwiftyExamples",
			dependencies: ["SwiftyEndpoint"],
			path: "SwiftyExamples"),
        .testTarget(
            name: "SwiftyEndpointTests",
            dependencies: ["SwiftyEndpoint", "SwiftyExamples"]
        ),
    ]
)
