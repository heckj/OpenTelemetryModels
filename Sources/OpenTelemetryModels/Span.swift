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

    public func isValid() -> Bool {
        id != Data(count: 8)
    }
}

public struct TraceID: Identifiable, Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {

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
            return id.base64EncodedString()
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

    public func isValid() -> Bool {
        id != Data(count: 16)
    }
}
