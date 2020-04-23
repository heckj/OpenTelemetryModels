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

var rng = SystemRandomNumberGenerator()

public struct SpanID: Identifiable, Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    public static let DataSize = 8

    // Comparable conformance
    public static func < (lhs: SpanID, rhs: SpanID) -> Bool {
        lhs.id.lexicographicallyPrecedes(rhs.id)
    }

    // CustomStringConvertible conformance
    public var description: String {
        get {
            return id.base64EncodedString()
        }
    }

    // CustomDebugStringConvertible conformance
    public var debugDescription: String {
        get {
            return "SpanID(\(id.hexEncodedString()))"
        }
    }

    public let id: Data

    public init() {
        var randomUInt64 = rng.next()
        // make sure we don't get an invalid ID
        while (randomUInt64 == 0) {
            randomUInt64 = rng.next()
        }
        id = withUnsafeBytes(of: &randomUInt64) { Data($0) }
    }

    // failable initializer for creating an instance from raw Data buffer
    public init?(from data: Data) {
        if data.count == SpanID.DataSize && data != Data(count: SpanID.DataSize) {
            id = data
        } else {
            return nil
        }
    }

    public func isValid() -> Bool {
        id != Data(count: SpanID.DataSize)
    }
}

public struct TraceID: Identifiable, Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    public static let DataSize = 16

    // Comparable conformance
    public static func < (lhs: TraceID, rhs: TraceID) -> Bool {
        lhs.id.lexicographicallyPrecedes(rhs.id)
    }

    // CustomStringConvertible conformance
    public var description: String {
           get {
            return id.base64EncodedString()
           }
       }

    // CustomDebugStringConvertible conformance
    public var debugDescription: String {
           get {
            return "TraceID(\(id.hexEncodedString()))"
           }
       }

    public let id: Data

    public init() {
        var randomUInt64 = rng.next()
        // make sure we don't get an invalid ID
        while (randomUInt64 == 0) {
            randomUInt64 = rng.next()
        }
        var data = withUnsafeBytes(of: &randomUInt64) { Data($0) }
        // add 8 more bytes to get to the required 16 byte length for a traceID
        var moreRandomNumber = rng.next()
        let moreData = withUnsafeBytes(of: &moreRandomNumber) { Data($0) }
        data.append(moreData)
        id = data
    }

    // failable initializer for creating an instance from raw Data buffer
    public init?(from data: Data) {
        if data.count == TraceID.DataSize && data != Data(count: TraceID.DataSize) {
            id = data
        } else {
            return nil
        }
    }

    public func isValid() -> Bool {
        id != Data(count: TraceID.DataSize)
    }
}

public extension Date {
    func timeUnixNano() -> UInt64 {
        return UInt64(self.timeIntervalSince1970)
    }
}

public extension Opentelemetry_Proto_Trace_V1_Status {
    //public typealias Status = Opentelemetry_Proto_Trace_V1_Status

    static func statusFromCode(code: Opentelemetry_Proto_Trace_V1_Status.StatusCode, message: String?) -> Opentelemetry_Proto_Trace_V1_Status {
        var status = Opentelemetry_Proto_Trace_V1_Status()
        status.code = code
        if let message = message {
            status.message = message
        }
        return status
    }
}

public extension Opentelemetry_Proto_Trace_V1_Status {
    static func status(_ message: String, withCode: Opentelemetry_Proto_Trace_V1_Status.StatusCode) -> Opentelemetry_Proto_Trace_V1_Status {
        var newstatus = Opentelemetry_Proto_Trace_V1_Status()
        newstatus.message = message
        newstatus.code = withCode
        return newstatus
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
    
    static func newEvent(_ name: String, timestamp: Date = Date()) -> Opentelemetry_Proto_Trace_V1_Span.Event {
        var event = Opentelemetry_Proto_Trace_V1_Span.Event()
        event.name = name
        event.timeUnixNano = timestamp.timeUnixNano()
        return event
    }
}

extension Opentelemetry_Proto_Trace_V1_Span: CustomStringConvertible, CustomDebugStringConvertible, CustomPlaygroundDisplayConvertible {
    public var description: String {
        guard let id = SpanID(from: spanID) else {
            return "Span(\(name):???)"
        }
        return "Span(\(name):\(String(describing: id)))"
    }
    
    public var debugDescription: String {
        guard let spanid = SpanID(from: spanID) else {
            return "Span[\(name):???:???]"
        }
        guard let traceid = TraceID(from: traceID) else {
            return "Span[\(name):\(String(reflecting: spanid)):???]"
        }
        return "Span[\(name):\(String(reflecting: spanid)):\(String(reflecting: traceid))]"
    }

    public var playgroundDescription: Any {
        return "Span"
    }
}

public extension Opentelemetry_Proto_Common_V1_AttributeKeyValue {
    //public typealias Status = Opentelemetry_Proto_Trace_V1_Status

    static func newAttribute(key: String, value: String) -> Opentelemetry_Proto_Common_V1_AttributeKeyValue {
        var attr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        attr.key = key
        attr.stringValue = value
        attr.type = .string
        return attr
    }

    static func newAttribute(key: String, value: Bool) -> Opentelemetry_Proto_Common_V1_AttributeKeyValue {
        var attr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        attr.key = key
        attr.boolValue = value
        attr.type = .bool
        return attr
    }

    static func newAttribute(key: String, value: Double) -> Opentelemetry_Proto_Common_V1_AttributeKeyValue {
        var attr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        attr.key = key
        attr.doubleValue = value
        attr.type = .double
        return attr
    }

    static func newAttribute(key: String, value: Int) -> Opentelemetry_Proto_Common_V1_AttributeKeyValue {
        var attr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        attr.key = key
        attr.intValue = Int64(value)
        attr.type = .int
        return attr
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

    // Tag on a span (attribute K/V pair) functions

    mutating func addTag(tag: String, value: Double) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.doubleValue = value
        self.attributes.append(newAttr)
    }

    mutating func addTag(tag: String, value: Bool) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.boolValue = value
        self.attributes.append(newAttr)
    }

    mutating func addTag(tag: String, value: Int) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.intValue = Int64(value)
        self.attributes.append(newAttr)
    }

    mutating func addTag(tag: String, value: String) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.stringValue = value
        self.attributes.append(newAttr)
    }

    // Event methods

    mutating func addEvent(_ name: String, timestamp: Date = Date()) {
        let evt = Self.newEvent(name, timestamp: timestamp)
        self.events.append(evt)
    }
}

extension Opentelemetry_Proto_Trace_V1_Span.Event {

    // Tag on an event (attribute K/V pair) functions

    mutating func addTag(tag: String, value: Double) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.doubleValue = value
        self.attributes.append(newAttr)
    }

    mutating func addTag(tag: String, value: Bool) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.boolValue = value
        self.attributes.append(newAttr)
    }

    mutating func addTag(tag: String, value: Int) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.intValue = Int64(value)
        self.attributes.append(newAttr)
    }

    mutating func addTag(tag: String, value: String) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.stringValue = value
        self.attributes.append(newAttr)
    }

}

