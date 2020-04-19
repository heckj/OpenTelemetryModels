//
//  SpanTests.swift
//  
//  Created by Joseph Heck on 4/19/20.
//


import XCTest
@testable import OpenTelemetryModels

final class SpanTests: XCTestCase {
    func testSpanIDInitializer() {
        let x = SpanID()
        XCTAssertTrue(x.isValid())
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
        // print(result)
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
