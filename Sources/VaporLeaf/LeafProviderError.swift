import Debugging

public enum LeafProviderError: Debuggable {
    case stemNotSet
}

extension LeafProviderError {
    public var identifier: String {
        return "stemNotSet"
    }

    public var reason: String {
        return "the stem hasn't been created and set on the droplet yet"
    }

    public var possibleCauses: [String] {
        return [
            "accessed drop.stem() before adding the leafProvider",
            "LeafProvider isn't being used and stem is inaccessible"
        ]
    }

    public var suggestedFixes: [String] {
        return [
            "don't access stem until after adding LeafProvider",
            "add LeafProvider with 'drop.addProvider(LeafProvider())'"
        ]
    }
}
