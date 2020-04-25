//
//  AttributeKeyValueTests.swift
//
//  Created by Joseph Heck on 4/20/20.
//

import XCTest
@testable import OpenTelemetryModels

final class AttributeKeyValueTests: XCTestCase {

    // initialization

    func test_builtinKV_init() {
        let attr = OpenTelemetry.Attribute()
        XCTAssertNotNil(attr)
        XCTAssertEqual(attr.type, .string)
        XCTAssertEqual(attr.key, "")
        XCTAssertEqual(attr.stringValue, "")
        XCTAssertEqual(attr.boolValue, false)
        XCTAssertEqual(attr.intValue, 0)
        XCTAssertEqual(attr.doubleValue, 0.0)
        
        XCTAssertEqual(String(describing: attr), "Attr(:)");
        XCTAssertEqual(String(reflecting: attr), "Attr[:]");
    }

    func test_newAttribute_string() {
        let attr = OpenTelemetry.Attribute("foo", "bar")
        XCTAssertNotNil(attr)
        XCTAssertEqual(attr.type, .string)
        XCTAssertEqual(attr.key, "foo")
        XCTAssertEqual(attr.stringValue, "bar")
        // defaults for the rest
        XCTAssertEqual(attr.boolValue, false)
        XCTAssertEqual(attr.intValue, 0)
        XCTAssertEqual(attr.doubleValue, 0.0)
        
        XCTAssertEqual(String(describing: attr), "Attr(foo:bar)");
        XCTAssertEqual(String(reflecting: attr), "Attr[foo:bar]");

    }

    func test_newAttribute_bool() {
        let attr = OpenTelemetry.Attribute("foo", true)
        XCTAssertNotNil(attr)
        XCTAssertEqual(attr.type, .bool)
        XCTAssertEqual(attr.key, "foo")
        XCTAssertEqual(attr.boolValue, true)
        // defaults for the rest
        XCTAssertEqual(attr.stringValue, "")
        XCTAssertEqual(attr.intValue, 0)
        XCTAssertEqual(attr.doubleValue, 0.0)
        
        XCTAssertEqual(String(describing: attr), "Attr(foo:true)");
        XCTAssertEqual(String(reflecting: attr), "Attr[foo:true]");
    }

    func test_newAttribute_int() {
        let attr = OpenTelemetry.Attribute("foo", 10)
        XCTAssertNotNil(attr)
        XCTAssertEqual(attr.type, .int)
        XCTAssertEqual(attr.key, "foo")
        XCTAssertEqual(attr.intValue, 10)
        // defaults for the rest
        XCTAssertEqual(attr.stringValue, "")
        XCTAssertEqual(attr.boolValue, false)
        XCTAssertEqual(attr.doubleValue, 0.0)
        
        XCTAssertEqual(String(describing: attr), "Attr(foo:10)");
        XCTAssertEqual(String(reflecting: attr), "Attr[foo:10]");
    }

    func test_newAttribute_double() {
        let attr = OpenTelemetry.Attribute("foo", 5.5)
        XCTAssertNotNil(attr)
        XCTAssertEqual(attr.type, .double)
        XCTAssertEqual(attr.key, "foo")
        XCTAssertEqual(attr.doubleValue, 5.5)
        // defaults for the rest
        XCTAssertEqual(attr.stringValue, "")
        XCTAssertEqual(attr.boolValue, false)
        XCTAssertEqual(attr.intValue, 0)
        
        XCTAssertEqual(String(describing: attr), "Attr(foo:5.5)");
        XCTAssertEqual(String(reflecting: attr), "Attr[foo:5.5]");
    }

}
