import XCTest
import Vapor
@testable import VaporLeaf

class LeafProviderTests: XCTestCase {
    static let allTests = [
        ("testProvider", testProvider),
    ]

    func testProvider() throws {
        let drop = try Droplet()
        try drop.addProvider(Provider.self)
        let stem = try drop.stem()
        XCTAssertNil(stem.cache)
    }
}
