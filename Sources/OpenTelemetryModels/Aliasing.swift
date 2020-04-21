//
//  Aliasing.swift
//
//  Created by Joseph Heck on 4/17/20.


import Foundation

// encapsulate the alias names into an enumeration to simulate a namespace
public enum OpenTelemetry {
    // obj:
    public typealias Status = Opentelemetry_Proto_Trace_V1_Status

    // enum:
    public typealias StatusCode = Opentelemetry_Proto_Trace_V1_Status.StatusCode

    // obj:
    public typealias Span = Opentelemetry_Proto_Trace_V1_Span

    // obj:
    public typealias Event = Opentelemetry_Proto_Trace_V1_Span.Event

    // obj:
    public typealias SpanLink = Opentelemetry_Proto_Trace_V1_Span.Link

    // enum:
    public typealias SpanKind = Opentelemetry_Proto_Trace_V1_Span.SpanKind

    // obj:
    public typealias Attribute = Opentelemetry_Proto_Common_V1_AttributeKeyValue

}
