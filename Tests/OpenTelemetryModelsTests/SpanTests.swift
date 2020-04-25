//
//  SpanTests.swift
//  
//  Created by Joseph Heck on 4/19/20.
//


import XCTest
@testable import OpenTelemetryModels

final class SpanStatusTests: XCTestCase {

    // initialization

    func testSpanStatus_init() {
        let status = OpenTelemetry.Status("new", withCode: .failedPrecondition)
        XCTAssertNotNil(status)
        XCTAssertEqual(status.message, "new")
        XCTAssertEqual(status.code, .failedPrecondition)
    }

    func testSpanStatus_default_init() {
        let status = OpenTelemetry.Status()
        XCTAssertNotNil(status)
        XCTAssertEqual(status.message, "")
        XCTAssertEqual(status.code, .ok)
    }

}

final class SpanTests: XCTestCase {

    func testSpan_default_initializer() {
        let span = Opentelemetry_Proto_Trace_V1_Span()
        XCTAssertNotNil(span)
        XCTAssertEqual(span.spanID.count, 0)
        XCTAssertEqual(span.traceID.count, 0)
        XCTAssertEqual(span.name, "")
        XCTAssertNotNil(span.startDate())
        XCTAssertEqual(span.startTimeUnixNano, 0)
        XCTAssertNil(span.endDate())
        XCTAssertEqual(span.endTimeUnixNano, 0)
        XCTAssertFalse(span.hasStatus)
        XCTAssertEqual(span.kind, .unspecified)
        XCTAssertEqual(span.events.count, 0)
        XCTAssertEqual(span.attributes.count, 0)
    }
    
    func testSpan_convenience_initializer() {
        let span = Opentelemetry_Proto_Trace_V1_Span("mary")
        XCTAssertEqual(span.spanID.count, 8)
        XCTAssertEqual(span.traceID.count, 16)
        XCTAssertNotNil(span)
        XCTAssertEqual(span.name, "mary")
        XCTAssertNotNil(span.startDate())
        XCTAssertTrue(span.startTimeUnixNano > 0)
        
        XCTAssertNil(span.endDate())
        XCTAssertEqual(span.endTimeUnixNano, 0)
        XCTAssertFalse(span.hasStatus)
        XCTAssertEqual(span.kind, .unspecified)
        XCTAssertEqual(span.events.count, 0)
        XCTAssertEqual(span.attributes.count, 0)
    }
    
    // String conformances
    
    func testSpan_description() {
        let span = Opentelemetry_Proto_Trace_V1_Span("mary")
        let result = String(describing: span)
        print(result)
        XCTAssertTrue(result.starts(with: "Span(mary"))
    }

    func testSpan_debugDescription() {
        let span = Opentelemetry_Proto_Trace_V1_Span("mary")
        let result = String(reflecting: span)
        print(result)
        XCTAssertTrue(result.starts(with: "Span[mary"))
        XCTAssertTrue(result.contains("SpanID"))
        XCTAssertTrue(result.contains("TraceID"))
        XCTAssertFalse(result.contains("???"))
    }

    // start & finish

    func testSpan_start() {
        let span = Opentelemetry_Proto_Trace_V1_Span.start(name: "fred")
        XCTAssertNotNil(span)
        XCTAssertEqual(span.name, "fred")
        XCTAssertNotNil(span.startDate())
        XCTAssertNil(span.endDate())
        XCTAssertFalse(span.hasStatus)
        XCTAssertEqual(span.kind, .unspecified)
    }

    func testSpan_start_withKind() {
        let span = Opentelemetry_Proto_Trace_V1_Span.start(name: "newspan", kind: .internal)
        XCTAssertNotNil(span)
        XCTAssertEqual(span.name, "newspan")
        XCTAssertNotNil(span.startDate())
        XCTAssertNil(span.endDate())
        XCTAssertFalse(span.hasStatus)
        XCTAssertEqual(span.kind, .internal)
    }

    func testSpan_createChildSpan() {
        let span = Opentelemetry_Proto_Trace_V1_Span.start(name: "parent")
        let child = span.createChildSpan(name: "child")

        XCTAssertEqual(span.name, "parent")
        XCTAssertEqual(child.name, "child")
        XCTAssertNotNil(span.startDate())
        XCTAssertNotNil(child.startDate())

        XCTAssertNil(span.endDate())
        XCTAssertNil(child.endDate())

        XCTAssertFalse(span.hasStatus)
        XCTAssertFalse(child.hasStatus)

        XCTAssertEqual(span.kind, .unspecified)
        XCTAssertEqual(child.kind, .unspecified)

        XCTAssertEqual(child.traceID, span.traceID)
        XCTAssertEqual(child.parentSpanID, span.spanID)
    }
    // TODO(heckj): test replication of attributes, tracestate, and any links

    func testSpan_finish() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "fred")
        XCTAssertNotNil(span)
        XCTAssertNil(span.endDate())

        span.finish()
        // after a default finish, it should have an end date
        // with a later end date
        XCTAssertNotNil(span.endDate())
        XCTAssertTrue(span.startTimeUnixNano >= span.endTimeUnixNano)
        // and a default status of OK
        XCTAssertEqual(span.status.code, Opentelemetry_Proto_Trace_V1_Status.StatusCode.ok)
        XCTAssertTrue(span.hasStatus)
    }

    func testSpan_finish_with_failureCode() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "fred")
        XCTAssertNotNil(span)
        XCTAssertNil(span.endDate())

        span.finish(withStatusCode: .notFound)
        // with a later end date
        XCTAssertNotNil(span.endDate())
        XCTAssertTrue(span.startTimeUnixNano >= span.endTimeUnixNano)        // and a default status of OK
        XCTAssertEqual(span.status.code, Opentelemetry_Proto_Trace_V1_Status.StatusCode.notFound)
        XCTAssertTrue(span.hasStatus)
    }

    func testSpan_finish_with_status() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "fred")
        XCTAssertNotNil(span)
        XCTAssertNil(span.endDate())

        var spanStatus = Opentelemetry_Proto_Trace_V1_Status()
        spanStatus.code = .aborted
        spanStatus.message = "abort message"
        span.finish(withStatus: spanStatus)
        // with a later end date
        XCTAssertNotNil(span.endDate())
        XCTAssertTrue(span.startTimeUnixNano >= span.endTimeUnixNano)
        // and a status
        XCTAssertNotNil(span.status)
        // and a default status of OK
        XCTAssertEqual(span.status.code, Opentelemetry_Proto_Trace_V1_Status.StatusCode.aborted)
        XCTAssertEqual(span.status.message, "abort message")
        XCTAssertTrue(span.hasStatus)
    }

    // tags

    func testSpan_setTag() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "parent")
        XCTAssertEqual(span.name, "parent")
        XCTAssertEqual(span.attributes.count, 0)

        span.setTag("bool", true)
        span.setTag("string", "string")
        span.setTag("double", 5.5)
        span.setTag("int", 10)
        XCTAssertEqual(span.attributes.count, 4)
        XCTAssertEqual(span.attributes[0].key, "bool")
        XCTAssertEqual(span.attributes[0].boolValue, true)
        XCTAssertEqual(span.attributes[1].key, "string")
        XCTAssertEqual(span.attributes[1].stringValue, "string")
        XCTAssertEqual(span.attributes[2].key, "double")
        XCTAssertEqual(span.attributes[2].doubleValue, 5.5)
        XCTAssertEqual(span.attributes[3].key, "int")
        XCTAssertEqual(span.attributes[3].intValue, 10)
    }

    func testSpan_tags_act_as_dict() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "parent")
        XCTAssertEqual(span.name, "parent")
        XCTAssertEqual(span.attributes.count, 0)

        span.setTag("foo", true)
        XCTAssertEqual(span.attributes.count, 1)
        XCTAssertEqual(span.attributes[0].key, "foo")
        XCTAssertEqual(span.attributes[0].boolValue, true)
        XCTAssertEqual(span.attributes[0].type, .bool)

        span.setTag("foo", "string")
        XCTAssertEqual(span.attributes.count, 1)
        XCTAssertEqual(span.attributes[0].key, "foo")
        XCTAssertEqual(span.attributes[0].stringValue, "string")
        XCTAssertEqual(span.attributes[0].type, .string)
    }

    func testSpan_subscript_read_attr() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "harriet")
        span.setTag("foo", true)
        XCTAssertEqual(span["foo"], OpenTelemetry.Attribute("foo", true))
    }

    // adding an event

    func testSpan_createEvent() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "parent")
        XCTAssertEqual(span.name, "parent")
        XCTAssertEqual(span.events.count, 0)
        span.addEvent("newevent")
        XCTAssertEqual(span.events.count, 1)
        XCTAssertEqual(span.events[0].name, "newevent")
    }
}
