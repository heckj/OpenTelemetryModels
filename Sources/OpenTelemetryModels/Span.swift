//
//  Span.swift
//  
//  Created by Joseph Heck on 4/19/20.
//

// The underlying type for Span is aliased to generated code from Protobuf
// public typealias Span = Opentelemetry_Proto_Trace_V1_Span as defined in Aliasing.swift

// This holds conveniences and extensions on the type to try and make it more useful within
// an idiomatic "swift" programming context.

// NOTE(heckj) - the generated code are primarily Structs, so everything here is leaning towards
// value based representations, not reference based representations. Treat and use accordingly.

import Foundation

public extension Date {
    func timeUnixNano() -> UInt64 {
        return UInt64(self.timeIntervalSince1970)
    }
}

public extension OpenTelemetry {
    // obj:
    typealias Span = Opentelemetry_Proto_Trace_V1_Span
    // obj:
    typealias Status = Opentelemetry_Proto_Trace_V1_Status

    // enum:
    typealias StatusCode = Opentelemetry_Proto_Trace_V1_Status.StatusCode
}

public extension Opentelemetry_Proto_Trace_V1_Status {

    init(code: Opentelemetry_Proto_Trace_V1_Status.StatusCode, message: String?) {
        self.code = code
        if let message = message {
            self.message = message
        }
    }
    
    init(_ message: String, withCode: Opentelemetry_Proto_Trace_V1_Status.StatusCode) {
        self.code = withCode
        self.message = message
    }
}


public extension Opentelemetry_Proto_Trace_V1_Span {
    init(_ name: String, start: Date = Date(), kind: Opentelemetry_Proto_Trace_V1_Span.SpanKind = .unspecified) {
        self.traceID = TraceID().id
        self.spanID = SpanID().id
        self.kind = kind
        self.name = name
        self.startTimeUnixNano = start.timeUnixNano()
    }
}

extension Opentelemetry_Proto_Trace_V1_Span: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        guard let id = SpanID(from: spanID) else {
            return "Span(\(name):???)"
        }
        return "Span(\(name):\(String(describing: id)))"
    }
    
    // consider adding timestamp into the debugDescription
    public var debugDescription: String {
        guard let spanid = SpanID(from: spanID) else {
            return "Span[\(name):???:???]"
        }
        guard let traceid = TraceID(from: traceID) else {
            return "Span[\(name):\(String(reflecting: spanid)):???]"
        }
        return "Span[\(name):\(String(reflecting: spanid)):\(String(reflecting: traceid))]"
    }
}

public extension Opentelemetry_Proto_Trace_V1_Span {

    // Convenience accessors

    func startDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self.startTimeUnixNano))
    }

    func endDate() -> Date? {
        // assume 0 means it was never set...
        if (self.endTimeUnixNano == 0) {
            return nil
        }
        // else convert to a Date() and hand back
        return Date(timeIntervalSince1970: TimeInterval(self.startTimeUnixNano))
    }

    // Start and Finish

    static func start(name: String,
               fromParent: Opentelemetry_Proto_Trace_V1_Span? = nil,
               kind: Opentelemetry_Proto_Trace_V1_Span.SpanKind = .unspecified,
               start: Date = Date()) -> Opentelemetry_Proto_Trace_V1_Span {
        var newSpan = Opentelemetry_Proto_Trace_V1_Span()
        if let parent = fromParent {
            newSpan.parentSpanID = parent.spanID
            // replicate traceState from a parent
            newSpan.traceState = parent.traceState
            // replicate the traceID from the parent
            newSpan.traceID = parent.traceID
            // copy all attributes from the parent
            newSpan.attributes = parent.attributes
            // copy all links ? (not sure if this is actually correct)
            newSpan.links = parent.links
        } else {
            newSpan.traceID = TraceID().id
        }
        newSpan.spanID = SpanID().id
        newSpan.name = name
        newSpan.kind = kind
        newSpan.startTimeUnixNano = start.timeUnixNano()
        return newSpan
    }

    static func start(name: String,
               kind: Opentelemetry_Proto_Trace_V1_Span.SpanKind = .unspecified,
               start: Date = Date()) -> Opentelemetry_Proto_Trace_V1_Span {
        var newSpan = Opentelemetry_Proto_Trace_V1_Span()
        newSpan.traceID = TraceID().id
        newSpan.spanID = SpanID().id
        newSpan.kind = kind
        newSpan.name = name
        newSpan.startTimeUnixNano = start.timeUnixNano()
        return newSpan
    }

    func createChildSpan(name: String) -> Opentelemetry_Proto_Trace_V1_Span {
        Opentelemetry_Proto_Trace_V1_Span.start(name: name, fromParent: self)
    }

    mutating func finish(end: Date = Date()) {
        self.endTimeUnixNano = end.timeUnixNano()

        var finalStatus = Opentelemetry_Proto_Trace_V1_Status()
        finalStatus.code = Opentelemetry_Proto_Trace_V1_Status.StatusCode.ok
        self.status = status
    }

    mutating func finish(end: Date = Date(), withStatus: Opentelemetry_Proto_Trace_V1_Status) {
        self.endTimeUnixNano = end.timeUnixNano()
        self.status = withStatus
    }

    mutating func finish(end: Date = Date(), withStatusCode: Opentelemetry_Proto_Trace_V1_Status.StatusCode) {
        self.endTimeUnixNano = end.timeUnixNano()
        var finalStatus = Opentelemetry_Proto_Trace_V1_Status()
        finalStatus.code = withStatusCode
        self.status = finalStatus
    }

    // enable subscript access to attributes
    subscript(tag: String) -> OpenTelemetry.Attribute? {
        return attributes.first(where: { $0.key == tag })
    }

    // Tag on a span (attribute K/V pair) functions

    mutating func setTag(_ tag: String, _ value: Double) {
                // if we find an index, we already have a tag with that name
        if let index = attributes.firstIndex(where: { $0.key == tag }) {
            // so replace it with a new tag with the updated value
            self.attributes[index] = OpenTelemetry.Attribute(tag, value)
        } else {
            // otherwise append in the newly provided tag
            self.attributes.append(OpenTelemetry.Attribute(tag, value))
        }
    }

    mutating func setTag(_ tag: String, _ value: Bool) {
                // if we find an index, we already have a tag with that name
        if let index = attributes.firstIndex(where: { $0.key == tag }) {
            // so replace it with a new tag with the updated value
            self.attributes[index] = OpenTelemetry.Attribute(tag, value)
        } else {
            // otherwise append in the newly provided tag
            self.attributes.append(OpenTelemetry.Attribute(tag, value))
        }
    }

    mutating func setTag(_ tag: String, _ value: Int) {
        // if we find an index, we already have a tag with that name
        if let index = attributes.firstIndex(where: { $0.key == tag }) {
            // so replace it with a new tag with the updated value
            self.attributes[index] = OpenTelemetry.Attribute(tag, value)
        } else {
            // otherwise append in the newly provided tag
            self.attributes.append(OpenTelemetry.Attribute(tag, value))
        }
    }

    mutating func setTag(_ tag: String, _ value: String) {
        // if we find an index, we already have a tag with that name
        if let index = attributes.firstIndex(where: { $0.key == tag }) {
            // so replace it with a new tag with the updated value
            self.attributes[index] = OpenTelemetry.Attribute(tag, value)
        } else {
            // otherwise append in the newly provided tag
            self.attributes.append(OpenTelemetry.Attribute(tag, value))
        }
    }

    // Event methods

    mutating func addEvent(_ name: String, timestamp: Date = Date()) {
        let evt = Event(name, at: timestamp)
        self.events.append(evt)
    }

    mutating func addEvent(_ evt: Event) {
        self.events.append(evt)
    }

}
