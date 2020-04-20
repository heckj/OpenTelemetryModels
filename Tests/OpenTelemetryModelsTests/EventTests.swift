//
//  EventTests.swift
//
//  Created by Joseph Heck on 4/19/20.
//

import XCTest
@testable import OpenTelemetryModels

final class EventTests: XCTestCase {

    // initialization

    func testEvent_init() {
        let x = Opentelemetry_Proto_Trace_V1_Span.Event()
        XCTAssertNotNil(x)
        XCTAssertEqual(x.name, "")
        XCTAssertEqual(x.attributes.count, 0)
        XCTAssertEqual(x.timeUnixNano, 0)
    }

    func testEvent_convenience_static_init() {
        let x = Opentelemetry_Proto_Trace_V1_Span.newEvent("foo")
        XCTAssertNotNil(x)
        XCTAssertEqual(x.name, "foo")
        XCTAssertEqual(x.attributes.count, 0)
        XCTAssertNotEqual(x.timeUnixNano, 0)
    }

}
