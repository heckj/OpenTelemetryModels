// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: opentelemetry/proto/trace/v1/trace.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// Copyright 2019, OpenTelemetry Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// A collection of InstrumentationLibrarySpans from a Resource.
public struct Opentelemetry_Proto_Trace_V1_ResourceSpans {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The resource for the spans in this message.
  /// If this field is not set then no resource info is known.
  public var resource: Opentelemetry_Proto_Resource_V1_Resource {
    get {return _resource ?? Opentelemetry_Proto_Resource_V1_Resource()}
    set {_resource = newValue}
  }
  /// Returns true if `resource` has been explicitly set.
  public var hasResource: Bool {return self._resource != nil}
  /// Clears the value of `resource`. Subsequent reads from it will return its default value.
  public mutating func clearResource() {self._resource = nil}

  /// A list of InstrumentationLibrarySpans that originate from a resource.
  public var instrumentationLibrarySpans: [Opentelemetry_Proto_Trace_V1_InstrumentationLibrarySpans] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _resource: Opentelemetry_Proto_Resource_V1_Resource? = nil
}

/// A collection of Spans produced by an InstrumentationLibrary.
public struct Opentelemetry_Proto_Trace_V1_InstrumentationLibrarySpans {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The instrumentation library information for the spans in this message.
  /// If this field is not set then no library info is known.
  public var instrumentationLibrary: Opentelemetry_Proto_Common_V1_InstrumentationLibrary {
    get {return _instrumentationLibrary ?? Opentelemetry_Proto_Common_V1_InstrumentationLibrary()}
    set {_instrumentationLibrary = newValue}
  }
  /// Returns true if `instrumentationLibrary` has been explicitly set.
  public var hasInstrumentationLibrary: Bool {return self._instrumentationLibrary != nil}
  /// Clears the value of `instrumentationLibrary`. Subsequent reads from it will return its default value.
  public mutating func clearInstrumentationLibrary() {self._instrumentationLibrary = nil}

  /// A list of Spans that originate from an instrumentation library.
  public var spans: [Opentelemetry_Proto_Trace_V1_Span] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _instrumentationLibrary: Opentelemetry_Proto_Common_V1_InstrumentationLibrary? = nil
}

/// Span represents a single operation within a trace. Spans can be
/// nested to form a trace tree. Spans may also be linked to other spans
/// from the same or different trace and form graphs. Often, a trace
/// contains a root span that describes the end-to-end latency, and one
/// or more subspans for its sub-operations. A trace can also contain
/// multiple root spans, or none at all. Spans do not need to be
/// contiguous - there may be gaps or overlaps between spans in a trace.
///
/// The next available field id is 17.
public struct Opentelemetry_Proto_Trace_V1_Span {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// A unique identifier for a trace. All spans from the same trace share
  /// the same `trace_id`. The ID is a 16-byte array. An ID with all zeroes
  /// is considered invalid.
  ///
  /// This field is semantically required. Receiver should generate new
  /// random trace_id if empty or invalid trace_id was received.
  ///
  /// This field is required.
  public var traceID: Data = SwiftProtobuf.Internal.emptyData

  /// A unique identifier for a span within a trace, assigned when the span
  /// is created. The ID is an 8-byte array. An ID with all zeroes is considered
  /// invalid.
  ///
  /// This field is semantically required. Receiver should generate new
  /// random span_id if empty or invalid span_id was received.
  ///
  /// This field is required.
  public var spanID: Data = SwiftProtobuf.Internal.emptyData

  /// trace_state conveys information about request position in multiple distributed tracing graphs.
  /// It is a trace_state in w3c-trace-context format: https://www.w3.org/TR/trace-context/#tracestate-header
  /// See also https://github.com/w3c/distributed-tracing for more details about this field.
  public var traceState: String = String()

  /// The `span_id` of this span's parent span. If this is a root span, then this
  /// field must be empty. The ID is an 8-byte array.
  public var parentSpanID: Data = SwiftProtobuf.Internal.emptyData

  /// A description of the span's operation.
  ///
  /// For example, the name can be a qualified method name or a file name
  /// and a line number where the operation is called. A best practice is to use
  /// the same display name at the same call point in an application.
  /// This makes it easier to correlate spans in different traces.
  ///
  /// This field is semantically required to be set to non-empty string.
  /// When null or empty string received - receiver may use string "name"
  /// as a replacement. There might be smarted algorithms implemented by
  /// receiver to fix the empty span name.
  ///
  /// This field is required.
  public var name: String = String()

  /// Distinguishes between spans generated in a particular context. For example,
  /// two spans with the same name may be distinguished using `CLIENT` (caller)
  /// and `SERVER` (callee) to identify queueing latency associated with the span.
  public var kind: Opentelemetry_Proto_Trace_V1_Span.SpanKind = .unspecified

  /// start_time_unix_nano is the start time of the span. On the client side, this is the time
  /// kept by the local machine where the span execution starts. On the server side, this
  /// is the time when the server's application handler starts running.
  /// Value is UNIX Epoch time in nanoseconds since 00:00:00 UTC on 1 January 1970.
  ///
  /// This field is semantically required and it is expected that end_time >= start_time.
  public var startTimeUnixNano: UInt64 = 0

  /// end_time_unix_nano is the end time of the span. On the client side, this is the time
  /// kept by the local machine where the span execution ends. On the server side, this
  /// is the time when the server application handler stops running.
  /// Value is UNIX Epoch time in nanoseconds since 00:00:00 UTC on 1 January 1970.
  ///
  /// This field is semantically required and it is expected that end_time >= start_time.
  public var endTimeUnixNano: UInt64 = 0

  /// attributes is a collection of key/value pairs. The value can be a string,
  /// an integer, a double or the Boolean values `true` or `false`. Note, global attributes
  /// like server name can be set using the resource API. Examples of attributes:
  ///
  ///     "/http/user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
  ///     "/http/server_latency": 300
  ///     "abc.com/myattribute": true
  ///     "abc.com/score": 10.239
  public var attributes: [Opentelemetry_Proto_Common_V1_AttributeKeyValue] = []

  /// dropped_attributes_count is the number of attributes that were discarded. Attributes
  /// can be discarded because their keys are too long or because there are too many
  /// attributes. If this value is 0, then no attributes were dropped.
  public var droppedAttributesCount: UInt32 = 0

  /// events is a collection of Event items.
  public var events: [Opentelemetry_Proto_Trace_V1_Span.Event] = []

  /// dropped_events_count is the number of dropped events. If the value is 0, then no
  /// events were dropped.
  public var droppedEventsCount: UInt32 = 0

  /// links is a collection of Links, which are references from this span to a span
  /// in the same or different trace.
  public var links: [Opentelemetry_Proto_Trace_V1_Span.Link] = []

  /// dropped_links_count is the number of dropped links after the maximum size was
  /// enforced. If this value is 0, then no links were dropped.
  public var droppedLinksCount: UInt32 = 0

  /// An optional final status for this span. Semantically when Status
  /// wasn't set it is means span ended without errors and assume
  /// Status.Ok (code = 0).
  public var status: Opentelemetry_Proto_Trace_V1_Status {
    get {return _status ?? Opentelemetry_Proto_Trace_V1_Status()}
    set {_status = newValue}
  }
  /// Returns true if `status` has been explicitly set.
  public var hasStatus: Bool {return self._status != nil}
  /// Clears the value of `status`. Subsequent reads from it will return its default value.
  public mutating func clearStatus() {self._status = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  /// SpanKind is the type of span. Can be used to specify additional relationships between spans
  /// in addition to a parent/child relationship.
  public enum SpanKind: SwiftProtobuf.Enum {
    public typealias RawValue = Int

    /// Unspecified. Do NOT use as default.
    /// Implementations MAY assume SpanKind to be INTERNAL when receiving UNSPECIFIED.
    case unspecified // = 0

    /// Indicates that the span represents an internal operation within an application,
    /// as opposed to an operations happening at the boundaries. Default value.
    case `internal` // = 1

    /// Indicates that the span covers server-side handling of an RPC or other
    /// remote network request.
    case server // = 2

    /// Indicates that the span describes a request to some remote service.
    case client // = 3

    /// Indicates that the span describes a producer sending a message to a broker.
    /// Unlike CLIENT and SERVER, there is often no direct critical path latency relationship
    /// between producer and consumer spans. A PRODUCER span ends when the message was accepted
    /// by the broker while the logical processing of the message might span a much longer time.
    case producer // = 4

    /// Indicates that the span describes consumer receiving a message from a broker.
    /// Like the PRODUCER kind, there is often no direct critical path latency relationship
    /// between producer and consumer spans.
    case consumer // = 5
    case UNRECOGNIZED(Int)

    public init() {
      self = .unspecified
    }

    public init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .unspecified
      case 1: self = .internal
      case 2: self = .server
      case 3: self = .client
      case 4: self = .producer
      case 5: self = .consumer
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    public var rawValue: Int {
      switch self {
      case .unspecified: return 0
      case .internal: return 1
      case .server: return 2
      case .client: return 3
      case .producer: return 4
      case .consumer: return 5
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  /// Event is a time-stamped annotation of the span, consisting of user-supplied
  /// text description and key-value pairs.
  public struct Event {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    /// time_unix_nano is the time the event occurred.
    public var timeUnixNano: UInt64 = 0

    /// name of the event.
    /// This field is semantically required to be set to non-empty string.
    public var name: String = String()

    /// attributes is a collection of attribute key/value pairs on the event.
    public var attributes: [Opentelemetry_Proto_Common_V1_AttributeKeyValue] = []

    /// dropped_attributes_count is the number of dropped attributes. If the value is 0,
    /// then no attributes were dropped.
    public var droppedAttributesCount: UInt32 = 0

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  /// A pointer from the current span to another span in the same trace or in a
  /// different trace. For example, this can be used in batching operations,
  /// where a single batch handler processes multiple requests from different
  /// traces or when the handler receives a request from a different project.
  public struct Link {
    // SwiftProtobuf.Message conformance is added in an extension below. See the
    // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
    // methods supported on all messages.

    /// A unique identifier of a trace that this linked span is part of. The ID is a
    /// 16-byte array.
    public var traceID: Data = SwiftProtobuf.Internal.emptyData

    /// A unique identifier for the linked span. The ID is an 8-byte array.
    public var spanID: Data = SwiftProtobuf.Internal.emptyData

    /// The trace_state associated with the link.
    public var traceState: String = String()

    /// attributes is a collection of attribute key/value pairs on the link.
    public var attributes: [Opentelemetry_Proto_Common_V1_AttributeKeyValue] = []

    /// dropped_attributes_count is the number of dropped attributes. If the value is 0,
    /// then no attributes were dropped.
    public var droppedAttributesCount: UInt32 = 0

    public var unknownFields = SwiftProtobuf.UnknownStorage()

    public init() {}
  }

  public init() {}

  fileprivate var _status: Opentelemetry_Proto_Trace_V1_Status? = nil
}

#if swift(>=4.2)

extension Opentelemetry_Proto_Trace_V1_Span.SpanKind: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [Opentelemetry_Proto_Trace_V1_Span.SpanKind] = [
    .unspecified,
    .internal,
    .server,
    .client,
    .producer,
    .consumer,
  ]
}

#endif  // swift(>=4.2)

/// The Status type defines a logical error model that is suitable for different
/// programming environments, including REST APIs and RPC APIs.
public struct Opentelemetry_Proto_Trace_V1_Status {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The status code. This is optional field. It is safe to assume 0 (OK)
  /// when not set.
  public var code: Opentelemetry_Proto_Trace_V1_Status.StatusCode = .ok

  /// A developer-facing human readable error message.
  public var message: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  /// StatusCode mirrors the codes defined at
  /// https://github.com/open-telemetry/opentelemetry-specification/blob/master/specification/api-tracing.md#statuscanonicalcode
  public enum StatusCode: SwiftProtobuf.Enum {
    public typealias RawValue = Int
    case ok // = 0
    case cancelled // = 1
    case unknownError // = 2
    case invalidArgument // = 3
    case deadlineExceeded // = 4
    case notFound // = 5
    case alreadyExists // = 6
    case permissionDenied // = 7
    case resourceExhausted // = 8
    case failedPrecondition // = 9
    case aborted // = 10
    case outOfRange // = 11
    case unimplemented // = 12
    case internalError // = 13
    case unavailable // = 14
    case dataLoss // = 15
    case unauthenticated // = 16
    case UNRECOGNIZED(Int)

    public init() {
      self = .ok
    }

    public init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .ok
      case 1: self = .cancelled
      case 2: self = .unknownError
      case 3: self = .invalidArgument
      case 4: self = .deadlineExceeded
      case 5: self = .notFound
      case 6: self = .alreadyExists
      case 7: self = .permissionDenied
      case 8: self = .resourceExhausted
      case 9: self = .failedPrecondition
      case 10: self = .aborted
      case 11: self = .outOfRange
      case 12: self = .unimplemented
      case 13: self = .internalError
      case 14: self = .unavailable
      case 15: self = .dataLoss
      case 16: self = .unauthenticated
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    public var rawValue: Int {
      switch self {
      case .ok: return 0
      case .cancelled: return 1
      case .unknownError: return 2
      case .invalidArgument: return 3
      case .deadlineExceeded: return 4
      case .notFound: return 5
      case .alreadyExists: return 6
      case .permissionDenied: return 7
      case .resourceExhausted: return 8
      case .failedPrecondition: return 9
      case .aborted: return 10
      case .outOfRange: return 11
      case .unimplemented: return 12
      case .internalError: return 13
      case .unavailable: return 14
      case .dataLoss: return 15
      case .unauthenticated: return 16
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  public init() {}
}

#if swift(>=4.2)

extension Opentelemetry_Proto_Trace_V1_Status.StatusCode: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [Opentelemetry_Proto_Trace_V1_Status.StatusCode] = [
    .ok,
    .cancelled,
    .unknownError,
    .invalidArgument,
    .deadlineExceeded,
    .notFound,
    .alreadyExists,
    .permissionDenied,
    .resourceExhausted,
    .failedPrecondition,
    .aborted,
    .outOfRange,
    .unimplemented,
    .internalError,
    .unavailable,
    .dataLoss,
    .unauthenticated,
  ]
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "opentelemetry.proto.trace.v1"

extension Opentelemetry_Proto_Trace_V1_ResourceSpans: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ResourceSpans"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "resource"),
    2: .standard(proto: "instrumentation_library_spans"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._resource)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.instrumentationLibrarySpans)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._resource {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.instrumentationLibrarySpans.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.instrumentationLibrarySpans, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Opentelemetry_Proto_Trace_V1_ResourceSpans, rhs: Opentelemetry_Proto_Trace_V1_ResourceSpans) -> Bool {
    if lhs._resource != rhs._resource {return false}
    if lhs.instrumentationLibrarySpans != rhs.instrumentationLibrarySpans {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_InstrumentationLibrarySpans: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".InstrumentationLibrarySpans"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "instrumentation_library"),
    2: .same(proto: "spans"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularMessageField(value: &self._instrumentationLibrary)
      case 2: try decoder.decodeRepeatedMessageField(value: &self.spans)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._instrumentationLibrary {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    }
    if !self.spans.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.spans, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Opentelemetry_Proto_Trace_V1_InstrumentationLibrarySpans, rhs: Opentelemetry_Proto_Trace_V1_InstrumentationLibrarySpans) -> Bool {
    if lhs._instrumentationLibrary != rhs._instrumentationLibrary {return false}
    if lhs.spans != rhs.spans {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_Span: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Span"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "trace_id"),
    2: .standard(proto: "span_id"),
    3: .standard(proto: "trace_state"),
    4: .standard(proto: "parent_span_id"),
    5: .same(proto: "name"),
    6: .same(proto: "kind"),
    7: .standard(proto: "start_time_unix_nano"),
    8: .standard(proto: "end_time_unix_nano"),
    9: .same(proto: "attributes"),
    10: .standard(proto: "dropped_attributes_count"),
    11: .same(proto: "events"),
    12: .standard(proto: "dropped_events_count"),
    13: .same(proto: "links"),
    14: .standard(proto: "dropped_links_count"),
    15: .same(proto: "status"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.traceID)
      case 2: try decoder.decodeSingularBytesField(value: &self.spanID)
      case 3: try decoder.decodeSingularStringField(value: &self.traceState)
      case 4: try decoder.decodeSingularBytesField(value: &self.parentSpanID)
      case 5: try decoder.decodeSingularStringField(value: &self.name)
      case 6: try decoder.decodeSingularEnumField(value: &self.kind)
      case 7: try decoder.decodeSingularFixed64Field(value: &self.startTimeUnixNano)
      case 8: try decoder.decodeSingularFixed64Field(value: &self.endTimeUnixNano)
      case 9: try decoder.decodeRepeatedMessageField(value: &self.attributes)
      case 10: try decoder.decodeSingularUInt32Field(value: &self.droppedAttributesCount)
      case 11: try decoder.decodeRepeatedMessageField(value: &self.events)
      case 12: try decoder.decodeSingularUInt32Field(value: &self.droppedEventsCount)
      case 13: try decoder.decodeRepeatedMessageField(value: &self.links)
      case 14: try decoder.decodeSingularUInt32Field(value: &self.droppedLinksCount)
      case 15: try decoder.decodeSingularMessageField(value: &self._status)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.traceID.isEmpty {
      try visitor.visitSingularBytesField(value: self.traceID, fieldNumber: 1)
    }
    if !self.spanID.isEmpty {
      try visitor.visitSingularBytesField(value: self.spanID, fieldNumber: 2)
    }
    if !self.traceState.isEmpty {
      try visitor.visitSingularStringField(value: self.traceState, fieldNumber: 3)
    }
    if !self.parentSpanID.isEmpty {
      try visitor.visitSingularBytesField(value: self.parentSpanID, fieldNumber: 4)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 5)
    }
    if self.kind != .unspecified {
      try visitor.visitSingularEnumField(value: self.kind, fieldNumber: 6)
    }
    if self.startTimeUnixNano != 0 {
      try visitor.visitSingularFixed64Field(value: self.startTimeUnixNano, fieldNumber: 7)
    }
    if self.endTimeUnixNano != 0 {
      try visitor.visitSingularFixed64Field(value: self.endTimeUnixNano, fieldNumber: 8)
    }
    if !self.attributes.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.attributes, fieldNumber: 9)
    }
    if self.droppedAttributesCount != 0 {
      try visitor.visitSingularUInt32Field(value: self.droppedAttributesCount, fieldNumber: 10)
    }
    if !self.events.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.events, fieldNumber: 11)
    }
    if self.droppedEventsCount != 0 {
      try visitor.visitSingularUInt32Field(value: self.droppedEventsCount, fieldNumber: 12)
    }
    if !self.links.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.links, fieldNumber: 13)
    }
    if self.droppedLinksCount != 0 {
      try visitor.visitSingularUInt32Field(value: self.droppedLinksCount, fieldNumber: 14)
    }
    if let v = self._status {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 15)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Opentelemetry_Proto_Trace_V1_Span, rhs: Opentelemetry_Proto_Trace_V1_Span) -> Bool {
    if lhs.traceID != rhs.traceID {return false}
    if lhs.spanID != rhs.spanID {return false}
    if lhs.traceState != rhs.traceState {return false}
    if lhs.parentSpanID != rhs.parentSpanID {return false}
    if lhs.name != rhs.name {return false}
    if lhs.kind != rhs.kind {return false}
    if lhs.startTimeUnixNano != rhs.startTimeUnixNano {return false}
    if lhs.endTimeUnixNano != rhs.endTimeUnixNano {return false}
    if lhs.attributes != rhs.attributes {return false}
    if lhs.droppedAttributesCount != rhs.droppedAttributesCount {return false}
    if lhs.events != rhs.events {return false}
    if lhs.droppedEventsCount != rhs.droppedEventsCount {return false}
    if lhs.links != rhs.links {return false}
    if lhs.droppedLinksCount != rhs.droppedLinksCount {return false}
    if lhs._status != rhs._status {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_Span.SpanKind: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "SPAN_KIND_UNSPECIFIED"),
    1: .same(proto: "INTERNAL"),
    2: .same(proto: "SERVER"),
    3: .same(proto: "CLIENT"),
    4: .same(proto: "PRODUCER"),
    5: .same(proto: "CONSUMER"),
  ]
}

extension Opentelemetry_Proto_Trace_V1_Span.Event: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = Opentelemetry_Proto_Trace_V1_Span.protoMessageName + ".Event"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "time_unix_nano"),
    2: .same(proto: "name"),
    3: .same(proto: "attributes"),
    4: .standard(proto: "dropped_attributes_count"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularFixed64Field(value: &self.timeUnixNano)
      case 2: try decoder.decodeSingularStringField(value: &self.name)
      case 3: try decoder.decodeRepeatedMessageField(value: &self.attributes)
      case 4: try decoder.decodeSingularUInt32Field(value: &self.droppedAttributesCount)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.timeUnixNano != 0 {
      try visitor.visitSingularFixed64Field(value: self.timeUnixNano, fieldNumber: 1)
    }
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 2)
    }
    if !self.attributes.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.attributes, fieldNumber: 3)
    }
    if self.droppedAttributesCount != 0 {
      try visitor.visitSingularUInt32Field(value: self.droppedAttributesCount, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Opentelemetry_Proto_Trace_V1_Span.Event, rhs: Opentelemetry_Proto_Trace_V1_Span.Event) -> Bool {
    if lhs.timeUnixNano != rhs.timeUnixNano {return false}
    if lhs.name != rhs.name {return false}
    if lhs.attributes != rhs.attributes {return false}
    if lhs.droppedAttributesCount != rhs.droppedAttributesCount {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_Span.Link: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = Opentelemetry_Proto_Trace_V1_Span.protoMessageName + ".Link"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "trace_id"),
    2: .standard(proto: "span_id"),
    3: .standard(proto: "trace_state"),
    4: .same(proto: "attributes"),
    5: .standard(proto: "dropped_attributes_count"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularBytesField(value: &self.traceID)
      case 2: try decoder.decodeSingularBytesField(value: &self.spanID)
      case 3: try decoder.decodeSingularStringField(value: &self.traceState)
      case 4: try decoder.decodeRepeatedMessageField(value: &self.attributes)
      case 5: try decoder.decodeSingularUInt32Field(value: &self.droppedAttributesCount)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.traceID.isEmpty {
      try visitor.visitSingularBytesField(value: self.traceID, fieldNumber: 1)
    }
    if !self.spanID.isEmpty {
      try visitor.visitSingularBytesField(value: self.spanID, fieldNumber: 2)
    }
    if !self.traceState.isEmpty {
      try visitor.visitSingularStringField(value: self.traceState, fieldNumber: 3)
    }
    if !self.attributes.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.attributes, fieldNumber: 4)
    }
    if self.droppedAttributesCount != 0 {
      try visitor.visitSingularUInt32Field(value: self.droppedAttributesCount, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Opentelemetry_Proto_Trace_V1_Span.Link, rhs: Opentelemetry_Proto_Trace_V1_Span.Link) -> Bool {
    if lhs.traceID != rhs.traceID {return false}
    if lhs.spanID != rhs.spanID {return false}
    if lhs.traceState != rhs.traceState {return false}
    if lhs.attributes != rhs.attributes {return false}
    if lhs.droppedAttributesCount != rhs.droppedAttributesCount {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_Status: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Status"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "code"),
    2: .same(proto: "message"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.code)
      case 2: try decoder.decodeSingularStringField(value: &self.message)
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.code != .ok {
      try visitor.visitSingularEnumField(value: self.code, fieldNumber: 1)
    }
    if !self.message.isEmpty {
      try visitor.visitSingularStringField(value: self.message, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Opentelemetry_Proto_Trace_V1_Status, rhs: Opentelemetry_Proto_Trace_V1_Status) -> Bool {
    if lhs.code != rhs.code {return false}
    if lhs.message != rhs.message {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_Status.StatusCode: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "Ok"),
    1: .same(proto: "Cancelled"),
    2: .same(proto: "UnknownError"),
    3: .same(proto: "InvalidArgument"),
    4: .same(proto: "DeadlineExceeded"),
    5: .same(proto: "NotFound"),
    6: .same(proto: "AlreadyExists"),
    7: .same(proto: "PermissionDenied"),
    8: .same(proto: "ResourceExhausted"),
    9: .same(proto: "FailedPrecondition"),
    10: .same(proto: "Aborted"),
    11: .same(proto: "OutOfRange"),
    12: .same(proto: "Unimplemented"),
    13: .same(proto: "InternalError"),
    14: .same(proto: "Unavailable"),
    15: .same(proto: "DataLoss"),
    16: .same(proto: "Unauthenticated"),
  ]
}
