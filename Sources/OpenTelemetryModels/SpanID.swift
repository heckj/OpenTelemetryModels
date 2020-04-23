//
//  SpanID.swift
//  
//  Created by Joseph Heck on 4/23/20.
//

import Foundation

public struct SpanID: Identifiable, Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    public static let DataSize = 8
    private static var rng = SystemRandomNumberGenerator()

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
        var randomUInt64 = SpanID.rng.next()
        // make sure we don't get an invalid ID
        while (randomUInt64 == 0) {
            randomUInt64 = SpanID.rng.next()
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
