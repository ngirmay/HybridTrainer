// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "HybridTrainer",
    platforms: [
        .iOS(.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/ashleymills/Reachability.swift.git", from: "5.1.0")
    ],
    targets: [
        .target(
            name: "HybridTrainer",
            dependencies: [
                .product(name: "Reachability", package: "Reachability.swift")
            ]
        )
    ]
) 