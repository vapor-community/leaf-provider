import Core
import Vapor
import Leaf

/// Use this provider to use Leaf as your
/// view renderer
public final class LeafProvider: Provider {
    /// Use this to create a provider instance
    public init() {}

    /// The config in this scenario is ignored
    /// Droplet provides a views directory and we
    /// would like to avoid having disparate 
    /// directories. 
    /// This means that the viewsDir of the 'Droplet'
    /// will be used when configuring the view
    public convenience init(config: Config) throws {
        self.init()
    }

    public func boot(_ drop: Droplet) throws {
        let renderer = LeafRenderer(viewsDir: drop.viewsDir)

        // Disable cache by default in development
        // this allows users to update views
        // without rebuilding app
        if drop.environment == .development {
            renderer.stem.cache = nil
        }

        drop.view = renderer

        drop.storage[stemKey] = renderer.stem
    }

    public func beforeRun(_ drop: Droplet) throws {}
}

extension Droplet {
    /// If a leaf provider is properly configured,
    /// use this function to access the underlying
    /// leaf stem for things like adding tags
    public func stem() throws -> Stem {
        guard let stem = storage[stemKey] as? Stem else {
            throw LeafProviderError.stemNotSet
        }
        return stem
    }
}

