import XCTest
import Vapor
@testable import LeafProvider

class leaf_providerTests: XCTestCase {
    static let allTests = [
        ("testProvider", testProvider),
    ]

    func testProvider() throws {
        let drop = try Droplet()
        try drop.addProvider(LeafProvider.self)
        let stem = try drop.stem()
        XCTAssertNil(stem.cache)
    }
}
