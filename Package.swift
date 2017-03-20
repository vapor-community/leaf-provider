import PackageDescription

let alpha = Version(2,0,0, prereleaseIdentifiers: ["alpha"])

let package = Package(
    name: "VaporLeaf",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", alpha),
        .Package(url: "https://github.com/vapor/leaf.git", alpha),
    ]
)
