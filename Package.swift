import PackageDescription

let package = Package(
    name: "LeafProvider",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/leaf.git", majorVersion: 2),
    ]
)
