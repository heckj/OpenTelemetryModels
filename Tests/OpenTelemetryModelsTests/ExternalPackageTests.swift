//
//  ExternalPackageTests.swift
//
//  Created by Joseph Heck on 4/13/20.
//

import Foundation
import OpenTelemetryModels
import XCTest

final class PackagingTests: XCTestCase {
    func testManualTicks() {
        let x = OpenTelemetryModels.Example()
        //let trace = Opentelemetry_Proto_Trace_V1_Span()
        // verifies the struct is visible externally - else this won't compile
    }
}
