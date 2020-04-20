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

}
