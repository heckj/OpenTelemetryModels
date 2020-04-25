//
//  EventTests.swift
//
//  Created by Joseph Heck on 4/19/20.
//

import XCTest
@testable import OpenTelemetryModels

final class EventTests: XCTestCase {

    // initialization

    func testEvent_default_init() {
        let x = OpenTelemetry.Event()
        XCTAssertNotNil(x)
        XCTAssertEqual(x.name, "")
        XCTAssertEqual(x.attributes.count, 0)
        XCTAssertEqual(x.timeUnixNano, 0)
    }

    func testEvent_convenience_init() {
        let x = OpenTelemetry.Event("foo")
        XCTAssertNotNil(x)
        XCTAssertEqual(x.name, "foo")
        XCTAssertEqual(x.attributes.count, 0)
        XCTAssertTrue(x.timeUnixNano > 0)
    }

    func testEvent_convenience_attr_init() {
        let attrib = OpenTelemetry.Attribute("a","b")
        let x = OpenTelemetry.Event("foo", attr: [attrib])
        XCTAssertNotNil(x)
        XCTAssertEqual(x.name, "foo")
        XCTAssertEqual(x.attributes.count, 1)
        XCTAssertTrue(x.timeUnixNano > 0)
    }

    func testEvent_descriptions() {
        let x = OpenTelemetry.Event("foo")
        XCTAssertEqual(String(describing: x), "Event(foo)")
        XCTAssertEqual(String(reflecting: x), "Event[foo]")
    }

    // event tags

    func testEvent_createEvent() {
        var evt = OpenTelemetry.Event("newevent")
        XCTAssertEqual(evt.name, "newevent")
        XCTAssertEqual(evt.attributes.count, 0)

        evt.addTag("bool", true)
        evt.addTag("string", "string")
        XCTAssertEqual(evt.attributes.count, 2)
        XCTAssertEqual(evt.attributes[0].key, "bool")
        XCTAssertEqual(evt.attributes[1].key, "string")
    }

    func testEvent_tags_act_as_list() {
        var evt = OpenTelemetry.Event("newevent")
        XCTAssertEqual(evt.name, "newevent")
        XCTAssertEqual(evt.attributes.count, 0)

        evt.addTag("foo", true)
        evt.addTag("foo", "string")
        XCTAssertEqual(evt.attributes.count, 2)
        XCTAssertEqual(evt.attributes[0].key, "foo")
        XCTAssertEqual(evt.attributes[1].key, "foo")
    }

}
