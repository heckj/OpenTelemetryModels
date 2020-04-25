//
//  Attribute.swift
//
//  Created by Joseph Heck on 4/23/20.
//

import Foundation

public extension OpenTelemetry {
    // obj:
    typealias Attribute = Opentelemetry_Proto_Common_V1_AttributeKeyValue
}

public extension Opentelemetry_Proto_Common_V1_AttributeKeyValue {
    //public typealias Status = Opentelemetry_Proto_Trace_V1_Status

    init(_ key: String, _ value: String) {
        self.key = key
        self.stringValue = value
        self.type = .string
    }

    init(_ key: String, _ value: Bool) {
        self.key = key
        self.boolValue = value
        self.type = .bool
    }

    init(_ key: String, _ value: Double) {
        self.key = key
        self.doubleValue = value
        self.type = .double
    }

    init(_ key: String, _ value: Int) {
        self.key = key
        self.intValue = Int64(value)
        self.type = .int
    }
}

extension Opentelemetry_Proto_Common_V1_AttributeKeyValue: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        switch self.type {
        case .string:
            return "Attr(\(key):\(stringValue))"
        case .int:
            return "Attr(\(key):\(intValue))"
        case .double:
            return "Attr(\(key):\(doubleValue))"
        case .bool:
            return "Attr(\(key):\(boolValue))"
        case .UNRECOGNIZED(_):
            return "Attr(\(key):???)"
        }
    }
    
    public var debugDescription: String {
        switch self.type {
        case .string:
            return "Attr[\(key):\(stringValue)]"
        case .int:
            return "Attr[\(key):\(intValue)]"
        case .double:
            return "Attr[\(key):\(doubleValue)]"
        case .bool:
            return "Attr[\(key):\(boolValue)]"
        case .UNRECOGNIZED(_):
            return "Attr[\(key):???]"
        }
    }
}
