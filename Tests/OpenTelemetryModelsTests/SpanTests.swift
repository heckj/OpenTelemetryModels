//
//  SpanTests.swift
//  
//  Created by Joseph Heck on 4/19/20.
//


import XCTest
@testable import OpenTelemetryModels

final class SpanTests: XCTestCase {

    // start & finish

    func testSpan_start() {
        let span = Opentelemetry_Proto_Trace_V1_Span.start(name: "fred")
        XCTAssertNotNil(span)
        XCTAssertEqual(span.name, "fred")
        XCTAssertNotNil(span.startDate())
        XCTAssertNil(span.endDate())

    }

    // tags

    // events
}
