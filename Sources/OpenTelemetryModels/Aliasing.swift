//
//  Aliasing.swift
//
//  Created by Joseph Heck on 4/17/20.


import Foundation

// encapsulate the alias names into an enumeration to simulate a namespace
public enum OpenTelemetry {

    // obj:
    public typealias SpanLink = Opentelemetry_Proto_Trace_V1_Span.Link

    // enum:
    public typealias SpanKind = Opentelemetry_Proto_Trace_V1_Span.SpanKind

}
