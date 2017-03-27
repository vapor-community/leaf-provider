import XCTest
import Vapor
@testable import LeafProvider

class ProviderTests: XCTestCase {
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
