import Vapor
import Leaf

public final class LeafRenderer: ViewRenderer {
    public let stem: Stem
    public internal(set) var environment: Environment = .development {
        didSet {
            if environment == .development {
                shouldCache = false
            } else {
                shouldCache = true
            }
        }
    }
    
    public var shouldCache: Bool {
        didSet {
            if shouldCache {
                stem.cache = stem.cache ?? SystemCache<Leaf>(maxSize: 1.gigabytes)
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

    public init(_ stem: Stem) {
        self.stem = stem
        shouldCache = stem.cache != nil
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
