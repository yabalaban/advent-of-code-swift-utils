// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "aoc-utils",
    platforms: [
       .macOS(.v10_13),
    ],
    products: [
        .library(
            name: "AocUtils",
            targets: ["AocUtils"]),
    ],
    targets: [
        .target(
            name: "AocUtils"
        )
    ]
)
