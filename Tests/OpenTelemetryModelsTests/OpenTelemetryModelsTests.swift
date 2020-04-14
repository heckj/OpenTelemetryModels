import XCTest
@testable import OpenTelemetryModels

final class OpenTelemetryModelsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OpenTelemetryModels().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
