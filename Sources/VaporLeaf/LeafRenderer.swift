import Vapor
import Leaf

public enum LeafRendererError: Error {
    case noViewsDirectoryFor(Vapor.Provider.Type)
}

public final class LeafRenderer: ViewRenderer {
    public let stem: Stem
    public internal(set) var environment: Environment = .development
    public var providedStems: [String: Stem] = [:]

    public init(viewsDir: String) {
        stem = Stem(workingDirectory: viewsDir)
    }

    public func make(_ path: String, _ context: Node, for provider: Vapor.Provider.Type?) throws -> View {
        let stem = try getStem(for: provider)
        let leaf = try stem.spawnLeaf(named: path)
        let context = Context(context)
        let bytes = try stem.render(leaf, with: context)
        return View(data: bytes)
    }

    private func getStem(for provider: Vapor.Provider.Type?) throws -> Stem {
        return try provider.flatMap(getStem) ?? self.stem
    }

    private func getStem(for provider: Vapor.Provider.Type) throws -> Stem {
        let repositoryName = provider.repositoryName
        if let existing = providedStems[repositoryName] { return existing }
        guard let viewsDir = provider.viewsDir else {
            throw LeafRendererError.noViewsDirectoryFor(provider)
        }
        let new = Stem(workingDirectory: viewsDir)
        providedStems[repositoryName] = new
        return new
    }
}
