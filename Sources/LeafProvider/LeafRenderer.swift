import Vapor
import Leaf

public final class LeafRenderer: ViewRenderer {
    public let stem: Stem
    public internal(set) var environment: Environment = .development
    
    public var shouldCache: Bool {
        didSet {
            if shouldCache {
                stem.cache = [:]
            } else {
                stem.cache = nil
            }
        }
    }

    public init(viewsDir: String) {
        let file = DataFile(workDir: viewsDir)
        stem = Stem(file)
        shouldCache = false
    }

    public func make(_ path: String, _ context: Node) throws -> View {
        let leaf = try stem.spawnLeaf(at: path)
        let context = Context(context)
        let bytes = try stem.render(leaf, with: context)
        return View(data: bytes)
    }
}

// MARK: Config

extension LeafRenderer: ConfigInitializable {
    public convenience init(config: Config) throws {
        self.init(viewsDir: config.viewsDir)
    }
}
