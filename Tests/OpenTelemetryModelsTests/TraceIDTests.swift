//
//  TraceIDTests.swift
//  
//
//  Created by Joseph Heck on 4/19/20.
//


import XCTest
@testable import OpenTelemetryModels

final class TraceIDTests: XCTestCase {

    func testTraceID_default_initializer() {
        let x = TraceID()
        XCTAssertTrue(x.isValid())
    }

    func testTraceID_initializer() {
        let x = TraceID()
        let y = TraceID(from: x.id)
        XCTAssertNotNil(y)
        XCTAssertEqual(x, y)
    }

    func testTraceID_initializer_fail() {
        let badData = Data(count:16)
        let y = TraceID(from: badData)
        XCTAssertNil(y)

        var badSource = UInt8(1)
        let differentBadData = withUnsafeBytes(of: &badSource) { Data($0) }
        let zfailure = TraceID(from: differentBadData)
        XCTAssertNil(zfailure)
    }

    func testTraceID_length_and_identifer() {
        let x = TraceID()
        XCTAssertEqual(x.id.count, 16)
    }

    func testTraceID_string() {
        let x = TraceID()
        // random ID, but we know it'll always be the same length
        let result = String(describing: x)
        XCTAssertEqual(result.count, 24)
        // print(result)
    }

    func testTraceID_debug_string() {
        let x = TraceID()
        // random ID, but we know it'll always be the same length
        let result = String(reflecting: x)
        XCTAssertEqual(result.count, 41)
        // print(result)
        XCTAssertTrue(result.starts(with: "TraceID("))
    }
}
