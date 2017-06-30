import Vapor
import Leaf

public final class LeafRenderer: ViewRenderer {
    public let stem: Stem
    public internal(set) var environment: Environment = .development
    public let cacheSize: Int
    
    public var shouldCache: Bool {
        didSet {
            if shouldCache {
                stem.cache = SystemCache<Leaf>(maxSize: cacheSize.megabytes)
            } else {
                stem.cache = nil
            }
        }
    }

    public init(viewsDir: String, cacheSize: Int? = nil) {
        let file = DataFile(workDir: viewsDir)
        stem = Stem(file)
        shouldCache = false
        self.cacheSize = cacheSize ?? 8
    }
    
    public func make(_ path: String, _ node: Node) throws -> View {
        return try self.make(path, Context(node))
    }
    
    public func make(_ path: String, _ context: LeafContext) throws -> View {
        let leaf = try stem.spawnLeaf(at: path)
        let bytes = try stem.render(leaf, with: context)
        return View(data: bytes)
    }
}

// MARK: Config

extension LeafRenderer: ConfigInitializable {
    public convenience init(config: Config) throws {
        self.init(
            viewsDir: config.viewsDir,
            cacheSize: config["leaf", "cacheSize"]?.int
        )
    }
}
