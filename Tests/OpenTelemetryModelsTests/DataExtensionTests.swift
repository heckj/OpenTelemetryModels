//
//  DataExtensionTests.swift
//
//  Created by Joseph Heck on 4/23/20.
//

import XCTest
@testable import OpenTelemetryModels

final class DataExtensionTests: XCTestCase {
    func testData_hexEncoding() {
        let data = Data([0, 1, 127, 128, 255])
        XCTAssertEqual(data.hexEncodedString(), "00017f80ff")
        XCTAssertEqual(data.hexEncodedString(options: .upperCase), "00017F80FF")
        // print(data.hexEncodedString()) // 00017f80ff
        // print(data.hexEncodedString(options: .upperCase)) // 00017F80FF
        
    }
}
