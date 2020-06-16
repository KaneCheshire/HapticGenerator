// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HapticGenerator",
    platforms: [.iOS("8.0")],
    products: [.library(name: "HapticGenerator", targets: ["HapticGenerator"])],
	targets: [.target(name: "HapticGenerator", path: "Sources")],
	swiftLanguageVersions: [.v5]
)
