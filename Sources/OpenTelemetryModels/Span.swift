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
            return "SpanID: \(id.base64EncodedString())"
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
            return "TraceID: \(id.base64EncodedString())"
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
               fromParent: Opentelemetry_Proto_Trace_V1_Span?,
               kind: Opentelemetry_Proto_Trace_V1_Span.SpanKind = .unspecified,
               start: Date = Date()) -> Opentelemetry_Proto_Trace_V1_Span {
        var newSpan = Opentelemetry_Proto_Trace_V1_Span()
        // newSpan.clearStatus()
        if let parent = fromParent {
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
        newSpan.startTimeUnixNano = start.timeUnixNano()
        return newSpan
    }

    static func start(name: String,
               kind: Opentelemetry_Proto_Trace_V1_Span.SpanKind = .unspecified,
               start: Date = Date()) -> Opentelemetry_Proto_Trace_V1_Span {
        var newSpan = Opentelemetry_Proto_Trace_V1_Span()
        newSpan.traceID = TraceID().id
        newSpan.spanID = SpanID().id
        newSpan.name = name
        newSpan.startTimeUnixNano = start.timeUnixNano()
        return newSpan
    }

    func createChildSpan(name: String) -> Opentelemetry_Proto_Trace_V1_Span {
        Opentelemetry_Proto_Trace_V1_Span.start(name: name, fromParent: self)
    }

    mutating func finish(end: Date = Date(), withStatus: Opentelemetry_Proto_Trace_V1_Status?) {
        self.endTimeUnixNano = end.timeUnixNano()
        if let status = withStatus {
            self.status = status
        }
    }

    mutating func finish(end: Date = Date(), withStatusCode: Opentelemetry_Proto_Trace_V1_Status.StatusCode?) {
        self.endTimeUnixNano = end.timeUnixNano()
        if let statusCode = withStatusCode {
            var finalStatus = Opentelemetry_Proto_Trace_V1_Status()
            finalStatus.code = statusCode
            self.status = finalStatus
        }
    }

    // Tag (attribute K/V pair) functions

    mutating func setTag(tag: String, value: Double) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.doubleValue = value
        self.attributes.append(newAttr)
    }

    mutating func setTag(tag: String, value: Bool) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.boolValue = value
        self.attributes.append(newAttr)
    }

    mutating func setTag(tag: String, value: Int) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.intValue = Int64(value)
        self.attributes.append(newAttr)
    }

    mutating func setTag(tag: String, value: String) {
        var newAttr = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        newAttr.key = tag
        newAttr.stringValue = value
        self.attributes.append(newAttr)
    }

    // TODO(heckj): add Event methods
}


