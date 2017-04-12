import Vapor
import Leaf

public enum LeafRendererError: Error {
    case noViewsDirectoryFor(Vapor.Provider.Type)
}

public final class LeafRenderer: ViewRenderer {
    public let stem: Stem
    public internal(set) var environment: Environment = .development

    public init(viewsDir: String) {
        stem = Stem(workingDirectory: viewsDir)
    }

    public func make(_ path: String, _ context: Node) throws -> View {
        let leaf: Leaf
        if path.hasPrefix("/") {
            leaf = try stem.spawnLeaf(at: path)
        } else {
            leaf = try stem.spawnLeaf(named: path)
        }
        let context = Context(context)
        let bytes = try stem.render(leaf, with: context)
        return View(data: bytes)
    }
}
