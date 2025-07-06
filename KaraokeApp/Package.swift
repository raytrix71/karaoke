// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KaraokeApp",
    platforms: [
        .iOS(.v16), .macOS(.v13)
    ],
    products: [
        .executable(name: "KaraokeApp", targets: ["KaraokeApp"])
    ],
    targets: [
        .executableTarget(
            name: "KaraokeApp",
            path: "Sources",
            resources: []
        )
    ]
)
