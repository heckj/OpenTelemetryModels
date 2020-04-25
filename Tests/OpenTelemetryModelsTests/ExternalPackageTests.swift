//
//  ExternalPackageTests.swift
//
//  Created by Joseph Heck on 4/13/20.
//

import Foundation
import OpenTelemetryModels
import XCTest

final class PackagingTests: XCTestCase {
    func testExposedClassesExist() {
        // verifies the struct is visible externally - otherwise this won't compile
        // in proto 0.3.0 - trace is beta
        let _ = Opentelemetry_Proto_Trace_V1_Span()
        let _ = Opentelemetry_Proto_Trace_V1_Status()
        let _ = Opentelemetry_Proto_Trace_V1_TraceConfig()
        let _ = Opentelemetry_Proto_Trace_V1_ResourceSpans()
        let _ = Opentelemetry_Proto_Trace_V1_ConstantSampler()
        let _ = Opentelemetry_Proto_Trace_V1_ProbabilitySampler()
        let _ = Opentelemetry_Proto_Trace_V1_RateLimitingSampler()
        
        // in proto 0.3.0 - resource is beta
        let _ = Opentelemetry_Proto_Resource_V1_Resource()
        
        // in proto 0.3.0 - common is beta
        let _ = Opentelemetry_Proto_Common_V1_StringKeyValue()
        let _ = Opentelemetry_Proto_Common_V1_AttributeKeyValue()
        let _ = Opentelemetry_Proto_Common_V1_InstrumentationLibrary()

        // in proto 0.3.0 - resource is alpha
        let _ = Opentelemetry_Proto_Metrics_V1_Metric()
    }
    
    func testExposedNicerNames() {
        let _ = OpenTelemetry.Span()
        let _ = OpenTelemetry.Status()
        let _ = OpenTelemetry.StatusCode()
        let _ = OpenTelemetry.Event()
        let _ = OpenTelemetry.SpanLink()
        let _ = OpenTelemetry.SpanKind()
        let _ = OpenTelemetry.Attribute()
    }

    func testExposedEventExtensions() {
        let _ = OpenTelemetry.Event("foo")
    }

    func testExposedAttributeExtensions() {
        let _ = OpenTelemetry.Attribute("foo",true)
    }

    func testExposedSpanExtensions() {
        let _ = OpenTelemetry.Span("foo")
    }

}
