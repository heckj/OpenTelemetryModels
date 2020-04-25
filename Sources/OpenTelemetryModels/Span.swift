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

    init(_ name: String,
         span: SpanID = SpanID(),
         fromParent: OpenTelemetry.Span? = nil,
         kind: OpenTelemetry.SpanKind = .unspecified,
         start: Date = Date(),
         attr: [OpenTelemetry.Attribute] = []) {
        self.spanID = SpanID().id
        self.name = name
        // NOTE(heckj): kind of an open question - but I think we'll always want
        // to create a span with a startTime. I don't think there's a use case
        // where we want to relegate this to another method (such as Span.start()
        self.startTimeUnixNano = start.timeUnixNano()
        self.kind = kind
        self.attributes = attr
        if let parent = fromParent {
            self.parentSpanID = parent.spanID
            // replicate the traceID from the parent
            self.traceID = parent.traceID
        } else {
            self.traceID = TraceID().id
        }
    }

    static func start(name: String,
                      fromParent: OpenTelemetry.Span? = nil,
                      kind: OpenTelemetry.SpanKind = .unspecified,
                      attr: [OpenTelemetry.Attribute] = []
    ) -> OpenTelemetry.Span {
        return OpenTelemetry.Span(name, fromParent: fromParent, kind: kind, attr: attr)
    }

    func createChildSpan(name: String) -> OpenTelemetry.Span {
        OpenTelemetry.Span.start(name: name, fromParent: self)
    }

    mutating func finish(end: Date = Date()) {
        self.endTimeUnixNano = end.timeUnixNano()

        var finalStatus = OpenTelemetry.Status()
        finalStatus.code = OpenTelemetry.StatusCode.ok
        self.status = status
    }

    mutating func finish(end: Date = Date(), withStatus: OpenTelemetry.Status) {
        self.endTimeUnixNano = end.timeUnixNano()
        self.status = withStatus
    }

    mutating func finish(end: Date = Date(), withStatusCode: OpenTelemetry.StatusCode) {
        self.endTimeUnixNano = end.timeUnixNano()
        var finalStatus = OpenTelemetry.Status()
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
