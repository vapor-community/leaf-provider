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
        try config.addProvider(Provider.self)
        let drop = try Droplet(config: config)
        XCTAssert(drop.view is LeafRenderer)
        let stem = try drop.assertStem()
        XCTAssertNil(stem.cache)
    }
}
