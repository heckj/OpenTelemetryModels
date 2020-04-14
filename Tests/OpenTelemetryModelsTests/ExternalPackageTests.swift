//
//  ExternalPackageTests.swift
//
//  Created by Joseph Heck on 4/13/20.
//

import Foundation
import OpenTelemetryModels
import XCTest

final class PackagingTests: XCTestCase {
    func testExposedClasses() {
        // verifies the struct is visible externally - otherwise this won't compile
        let _ = Opentelemetry_Proto_Trace_V1_Span()
        let _ = OpenTelemetryModels.Opentelemetry_Proto_Trace_V1_Status()
        let _ = OpenTelemetryModels.Opentelemetry_Proto_Trace_V1_TraceConfig()
    }
}
