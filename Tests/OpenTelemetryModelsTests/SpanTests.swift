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
        let status = Opentelemetry_Proto_Trace_V1_Status.status("new", withCode: .failedPrecondition)
        XCTAssertNotNil(status)
        XCTAssertEqual(status.message, "new")
        XCTAssertEqual(status.code, .failedPrecondition)
    }

    func testSpanStatus_default_init() {
        let status = Opentelemetry_Proto_Trace_V1_Status()
        XCTAssertNotNil(status)
        XCTAssertEqual(status.message, "")
        XCTAssertEqual(status.code, .ok)
    }

}

final class SpanTests: XCTestCase {

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

        span.addTag(tag: "bool", value: true)
        span.addTag(tag: "string", value: "string")
        XCTAssertEqual(span.attributes.count, 2)
        XCTAssertEqual(span.attributes[0].key, "bool")
        XCTAssertEqual(span.attributes[1].key, "string")
    }

    func testSpan_tags_act_as_list() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "parent")
        XCTAssertEqual(span.name, "parent")
        XCTAssertEqual(span.attributes.count, 0)

        span.addTag(tag: "foo", value: true)
        span.addTag(tag: "foo", value: "string")
        XCTAssertEqual(span.attributes.count, 2)
        XCTAssertEqual(span.attributes[0].key, "foo")
        XCTAssertEqual(span.attributes[1].key, "foo")
    }

    // events

    func testSpan_createEvent() {
        var span = Opentelemetry_Proto_Trace_V1_Span.start(name: "parent")
        XCTAssertEqual(span.name, "parent")
        XCTAssertEqual(span.events.count, 0)
        span.addEvent("newevent")
        XCTAssertEqual(span.events.count, 1)
        XCTAssertEqual(span.events[0].name, "newevent")
    }

    // event tags

    func testEvent_createEvent() {
        var evt = OpenTelemetry.Span.newEvent("newevent")
        XCTAssertEqual(evt.name, "newevent")
        XCTAssertEqual(evt.attributes.count, 0)

        evt.addTag(tag: "bool", value: true)
        evt.addTag(tag: "string", value: "string")
        XCTAssertEqual(evt.attributes.count, 2)
        XCTAssertEqual(evt.attributes[0].key, "bool")
        XCTAssertEqual(evt.attributes[1].key, "string")
    }

    func testEvent_tags_act_as_list() {
        var evt = OpenTelemetry.Span.newEvent("newevent")
        XCTAssertEqual(evt.name, "newevent")
        XCTAssertEqual(evt.attributes.count, 0)

        evt.addTag(tag: "foo", value: true)
        evt.addTag(tag: "foo", value: "string")
        XCTAssertEqual(evt.attributes.count, 2)
        XCTAssertEqual(evt.attributes[0].key, "foo")
        XCTAssertEqual(evt.attributes[1].key, "foo")
    }

}
