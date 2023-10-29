// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Peeps",
    dependencies: [
        .package(url:"https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url:"https://github.com/SwiftyContacts/SwiftyContacts.git", .upToNextMajor(from: "4.0.0")),
    ],
    targets: [
        .executableTarget(
            name: "Peeps",
            dependencies: [
                .product(name:"ArgumentParser", package: "swift-argument-parser"),
                .product(name:"SwiftyContacts", package: "SwiftyContacts"),
            ],
            path: "Sources"),
    ]
)
