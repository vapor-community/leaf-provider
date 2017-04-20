import Core
import Vapor
import Leaf

/// Use this provider to use Leaf as your
/// view renderer
public final class Provider: Vapor.Provider {
    public static let repositoryName = "leaf-provider"
    
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
    
    public func boot(_ config: Config) throws {
        config.addConfigurable(view: LeafRenderer.init, name: "leaf")
    }

    public func boot(_ drop: Droplet) throws {
        if let leaf = drop.view as? LeafRenderer {
            drop.stem = leaf.stem
        }
    }

    public func beforeRun(_ drop: Droplet) throws {}
}

extension Droplet {
    public internal(set) var stem: Stem? {
        get { return storage[stemKey] as? Stem }
        set { storage[stemKey] = newValue }
    }
    
    /// If a leaf provider is properly configured,
    /// use this function to access the underlying
    /// leaf stem for things like adding tags
    public func assertStem() throws -> Stem {
        guard let stem = storage[stemKey] as? Stem else {
            throw LeafProviderError.stemNotSet
        }
        return stem
    }
}

