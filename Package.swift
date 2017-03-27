import PackageDescription

let beta = Version(2,0,0, prereleaseIdentifiers: ["beta"])

let package = Package(
    name: "LeafProvider",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", beta),
        .Package(url: "https://github.com/vapor/leaf.git", beta),
    ]
)
