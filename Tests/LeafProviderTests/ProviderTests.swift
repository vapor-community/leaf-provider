import XCTest
import Vapor
@testable import LeafProvider

class ProviderTests: XCTestCase {
    static let allTests = [
        ("testProvider", testProvider),
    ]

    func testProvider() throws {
        var config = Config([:])
        try config.set("droplet.view", "leaf")
        let drop = try Droplet(config: config)
        try drop.addProvider(Provider.self)
        XCTAssert(drop.view is LeafRenderer)
        let stem = try drop.stem()
        XCTAssertNil(stem.cache)
    }
}
