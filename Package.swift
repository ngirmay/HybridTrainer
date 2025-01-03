// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "HybridTrainer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "HybridTrainer",
            targets: ["HybridTrainer"]),
    ],
    targets: [
        .target(
            name: "HybridTrainer",
            path: "HybridTrainer"
        )
    ]
) 