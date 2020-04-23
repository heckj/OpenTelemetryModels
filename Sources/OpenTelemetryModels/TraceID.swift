//
//  TraceID.swift
//  
//  Created by Joseph Heck on 4/23/20.
//

import Foundation

public struct TraceID: Identifiable, Hashable, Comparable, CustomStringConvertible, CustomDebugStringConvertible {
    public static let DataSize = 16
    private static var rng = SystemRandomNumberGenerator()

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
        var randomUInt64 = TraceID.rng.next()
        // make sure we don't get an invalid ID
        while (randomUInt64 == 0) {
            randomUInt64 = TraceID.rng.next()
        }
        var data = withUnsafeBytes(of: &randomUInt64) { Data($0) }
        // add 8 more bytes to get to the required 16 byte length for a traceID
        var moreRandomNumber = TraceID.rng.next()
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
