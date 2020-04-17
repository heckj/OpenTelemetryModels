import XCTest
@testable import OpenTelemetryModels

final class OpenTelemetryModelsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(true, true)
    }
    
    func testExperimentsWithTraceStatus() {
        
        // poking at the raw models
        // NOTE(heckj): these won't be initialized as you might expect them
        // to be from a proper OpenTelemetryTracer - they're the raw models
        // that a tracer uses to encapsulate it's info.
        
        var newStatus = OpenTelemetry.Status()
        XCTAssertEqual(newStatus.message, "")
        XCTAssertEqual(newStatus.debugDescription, "OpenTelemetryModels.Opentelemetry_Proto_Trace_V1_Status:\n")
        XCTAssertTrue(newStatus.isInitialized)
        XCTAssertEqual(newStatus.code, OpenTelemetry.StatusCode.ok)
        
        // all proto models can be dumped into a JSON string
        XCTAssertEqual(try newStatus.jsonString(), "{}")
        // or dumped to binary, compact form w/ newStatus.serializedData()
        XCTAssertEqual(try newStatus.serializedData(), Data())
        print("textFormatString: ", newStatus.textFormatString())
        
        // add some values into the status
        newStatus.code = OpenTelemetry.StatusCode.notFound
        newStatus.message = "oopsie"

        let expectedJSONString = """
{"code":"NotFound","message":"oopsie"}
"""
        // all proto models can be dumped into a JSON string
        XCTAssertEqual(try newStatus.jsonString(), expectedJSONString)
        // or dumped to binary, compact form w/ newStatus.serializedData()
        // XCTAssertEqual(try newStatus.serializedData().count, 10) // 10 bytes
        // print("textFormatString: ", newStatus.textFormatString())
    }
    func testExperimentsWithTraceSpan() {

        let newSpan = OpenTelemetry.Span()
        XCTAssertEqual(newSpan.status.code, OpenTelemetry.StatusCode.ok)
        XCTAssertEqual(newSpan.attributes.count, 0)
        print("traceID: ", newSpan.traceID)
        print("spanID: ", newSpan.spanID)
        print("parentSpanID: ", newSpan.parentSpanID)
        
        // spans have
        // - traceID
        // - spanID
        // - traceState ""
        // - name ""
        // - kind (enum of SpanKind)
        // - startTimeUnixNano (UInt64)
        // - endTimeUnixNano (UInt64)
        // - attributes (K/V pairs, list 0 long)
        // - events (list 0 of Events)
        // - links (list 0 of Links)
        XCTAssertEqual(newSpan.traceState,"") // model has an empty initial state
    }

}
