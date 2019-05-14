// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "LeafProvider",
    dependencies: [
	       .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.0.0")),
         .package(url: "https://github.com/vapor/leaf.git", .upToNextMajor(from: "2.0.0")),
    ]
)
