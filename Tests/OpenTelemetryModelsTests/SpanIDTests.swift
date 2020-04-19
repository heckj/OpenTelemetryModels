//
//  SpanIDTests.swift
//
//  Created by Joseph Heck on 4/19/20.
//


import XCTest
@testable import OpenTelemetryModels

final class SpanIDTests: XCTestCase {
    func testSpanID_default_initializer() {
        let x = SpanID()
        XCTAssertTrue(x.isValid())
    }

    func testSpanID_initializer() {
        let x = SpanID()
        let y = SpanID(from: x.id)
        XCTAssertNotNil(y)
        XCTAssertEqual(x, y)
    }

    func testSpanID_initializer_fail() {
        let badData = Data(count:8)
        let y = SpanID(from: badData)
        XCTAssertNil(y)

        var badSource = String("whu?")
        let differentBadData = withUnsafeBytes(of: &badSource) { Data($0) }
        let zfailure = SpanID(from: differentBadData)
        XCTAssertNil(zfailure)
    }

    func testSpanID_length_and_identifer() {
        let x = SpanID()
        XCTAssertEqual(x.id.count, 8)
    }

    func testSpanID_string() {
        let x = SpanID()
        // random ID, but we know it'll always be the same length
        let result = String(describing: x)
        XCTAssertEqual(result.count, 12)
         print(result)
    }

    func testSpanID_debug_string() {
        let x = SpanID()
        // random ID, but we know it'll always be the same length
        let result = String(reflecting: x)
        XCTAssertEqual(result.count, 20)
        // print(result)
        XCTAssertTrue(result.starts(with: "SpanID: "))
    }
}
