//
//  Event.swift
//  
//
//  Created by Joseph Heck on 4/24/20.
//

import Foundation
public extension OpenTelemetry {
    // obj:
    typealias Event = Opentelemetry_Proto_Trace_V1_Span.Event
}

extension Opentelemetry_Proto_Trace_V1_Span.Event {

    init(_ name: String, at: Date = Date()) {
        self.name = name
        self.timeUnixNano = at.timeUnixNano()
    }
    
    init(_ name: String, at: Date = Date(), attr: [Opentelemetry_Proto_Common_V1_AttributeKeyValue]) {
        self.name = name
        self.timeUnixNano = at.timeUnixNano()
        self.attributes = attr
    }
    
    // Tag on an event (attribute K/V pair) functions
    mutating func addTag(_ tag: String, _ value: Double) {
        self.attributes.append(OpenTelemetry.Attribute(tag, value))
    }

    mutating func addTag(_ tag: String, _ value: Bool) {
        self.attributes.append(OpenTelemetry.Attribute(tag, value))

    }

    mutating func addTag(_ tag: String, _ value: Int) {
        self.attributes.append(OpenTelemetry.Attribute(tag, value))
    }

    mutating func addTag(_ tag: String, _ value: String) {
        self.attributes.append(OpenTelemetry.Attribute(tag, value))
    }

}

extension Opentelemetry_Proto_Trace_V1_Span.Event: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return "Event(\(name))"
    }
    
    // consider adding timestamp into the debugDescription
    public var debugDescription: String {
        return "Event[\(name)]"
    }
}
