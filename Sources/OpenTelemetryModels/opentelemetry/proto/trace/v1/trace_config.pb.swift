// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: opentelemetry/proto/trace/v1/trace_config.proto
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

/// Global configuration of the trace service. All fields must be specified, or
/// the default (zero) values will be used for each type.
struct Opentelemetry_Proto_Trace_V1_TraceConfig {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The global default sampler used to make decisions on span sampling.
  var sampler: Opentelemetry_Proto_Trace_V1_TraceConfig.OneOf_Sampler? = nil

  var constantSampler: Opentelemetry_Proto_Trace_V1_ConstantSampler {
    get {
      if case .constantSampler(let v)? = sampler {return v}
      return Opentelemetry_Proto_Trace_V1_ConstantSampler()
    }
    set {sampler = .constantSampler(newValue)}
  }

  var probabilitySampler: Opentelemetry_Proto_Trace_V1_ProbabilitySampler {
    get {
      if case .probabilitySampler(let v)? = sampler {return v}
      return Opentelemetry_Proto_Trace_V1_ProbabilitySampler()
    }
    set {sampler = .probabilitySampler(newValue)}
  }

  var rateLimitingSampler: Opentelemetry_Proto_Trace_V1_RateLimitingSampler {
    get {
      if case .rateLimitingSampler(let v)? = sampler {return v}
      return Opentelemetry_Proto_Trace_V1_RateLimitingSampler()
    }
    set {sampler = .rateLimitingSampler(newValue)}
  }

  /// The global default max number of attributes per span.
  var maxNumberOfAttributes: Int64 = 0

  /// The global default max number of annotation events per span.
  var maxNumberOfTimedEvents: Int64 = 0

  /// The global default max number of attributes per timed event.
  var maxNumberOfAttributesPerTimedEvent: Int64 = 0

  /// The global default max number of link entries per span.
  var maxNumberOfLinks: Int64 = 0

  /// The global default max number of attributes per span.
  var maxNumberOfAttributesPerLink: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  /// The global default sampler used to make decisions on span sampling.
  enum OneOf_Sampler: Equatable {
    case constantSampler(Opentelemetry_Proto_Trace_V1_ConstantSampler)
    case probabilitySampler(Opentelemetry_Proto_Trace_V1_ProbabilitySampler)
    case rateLimitingSampler(Opentelemetry_Proto_Trace_V1_RateLimitingSampler)

  #if !swift(>=4.1)
    static func ==(lhs: Opentelemetry_Proto_Trace_V1_TraceConfig.OneOf_Sampler, rhs: Opentelemetry_Proto_Trace_V1_TraceConfig.OneOf_Sampler) -> Bool {
      switch (lhs, rhs) {
      case (.constantSampler(let l), .constantSampler(let r)): return l == r
      case (.probabilitySampler(let l), .probabilitySampler(let r)): return l == r
      case (.rateLimitingSampler(let l), .rateLimitingSampler(let r)): return l == r
      default: return false
      }
    }
  #endif
  }

  init() {}
}

/// Sampler that always makes a constant decision on span sampling.
struct Opentelemetry_Proto_Trace_V1_ConstantSampler {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var decision: Opentelemetry_Proto_Trace_V1_ConstantSampler.ConstantDecision = .alwaysOff

  var unknownFields = SwiftProtobuf.UnknownStorage()

  /// How spans should be sampled:
  /// - Always off
  /// - Always on
  /// - Always follow the parent Span's decision (off if no parent).
  enum ConstantDecision: SwiftProtobuf.Enum {
    typealias RawValue = Int
    case alwaysOff // = 0
    case alwaysOn // = 1
    case alwaysParent // = 2
    case UNRECOGNIZED(Int)

    init() {
      self = .alwaysOff
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .alwaysOff
      case 1: self = .alwaysOn
      case 2: self = .alwaysParent
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .alwaysOff: return 0
      case .alwaysOn: return 1
      case .alwaysParent: return 2
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  init() {}
}

#if swift(>=4.2)

extension Opentelemetry_Proto_Trace_V1_ConstantSampler.ConstantDecision: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [Opentelemetry_Proto_Trace_V1_ConstantSampler.ConstantDecision] = [
    .alwaysOff,
    .alwaysOn,
    .alwaysParent,
  ]
}

#endif  // swift(>=4.2)

/// Sampler that tries to uniformly sample traces with a given probability.
/// The probability of sampling a trace is equal to that of the specified probability.
struct Opentelemetry_Proto_Trace_V1_ProbabilitySampler {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The desired probability of sampling. Must be within [0.0, 1.0].
  var samplingProbability: Double = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// Sampler that tries to sample with a rate per time window.
struct Opentelemetry_Proto_Trace_V1_RateLimitingSampler {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Rate per second.
  var qps: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "opentelemetry.proto.trace.v1"

extension Opentelemetry_Proto_Trace_V1_TraceConfig: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".TraceConfig"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "constant_sampler"),
    2: .standard(proto: "probability_sampler"),
    3: .standard(proto: "rate_limiting_sampler"),
    4: .standard(proto: "max_number_of_attributes"),
    5: .standard(proto: "max_number_of_timed_events"),
    6: .standard(proto: "max_number_of_attributes_per_timed_event"),
    7: .standard(proto: "max_number_of_links"),
    8: .standard(proto: "max_number_of_attributes_per_link"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1:
        var v: Opentelemetry_Proto_Trace_V1_ConstantSampler?
        if let current = self.sampler {
          try decoder.handleConflictingOneOf()
          if case .constantSampler(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.sampler = .constantSampler(v)}
      case 2:
        var v: Opentelemetry_Proto_Trace_V1_ProbabilitySampler?
        if let current = self.sampler {
          try decoder.handleConflictingOneOf()
          if case .probabilitySampler(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.sampler = .probabilitySampler(v)}
      case 3:
        var v: Opentelemetry_Proto_Trace_V1_RateLimitingSampler?
        if let current = self.sampler {
          try decoder.handleConflictingOneOf()
          if case .rateLimitingSampler(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {self.sampler = .rateLimitingSampler(v)}
      case 4: try decoder.decodeSingularInt64Field(value: &self.maxNumberOfAttributes)
      case 5: try decoder.decodeSingularInt64Field(value: &self.maxNumberOfTimedEvents)
      case 6: try decoder.decodeSingularInt64Field(value: &self.maxNumberOfAttributesPerTimedEvent)
      case 7: try decoder.decodeSingularInt64Field(value: &self.maxNumberOfLinks)
      case 8: try decoder.decodeSingularInt64Field(value: &self.maxNumberOfAttributesPerLink)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    switch self.sampler {
    case .constantSampler(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    case .probabilitySampler(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    case .rateLimitingSampler(let v)?:
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    case nil: break
    }
    if self.maxNumberOfAttributes != 0 {
      try visitor.visitSingularInt64Field(value: self.maxNumberOfAttributes, fieldNumber: 4)
    }
    if self.maxNumberOfTimedEvents != 0 {
      try visitor.visitSingularInt64Field(value: self.maxNumberOfTimedEvents, fieldNumber: 5)
    }
    if self.maxNumberOfAttributesPerTimedEvent != 0 {
      try visitor.visitSingularInt64Field(value: self.maxNumberOfAttributesPerTimedEvent, fieldNumber: 6)
    }
    if self.maxNumberOfLinks != 0 {
      try visitor.visitSingularInt64Field(value: self.maxNumberOfLinks, fieldNumber: 7)
    }
    if self.maxNumberOfAttributesPerLink != 0 {
      try visitor.visitSingularInt64Field(value: self.maxNumberOfAttributesPerLink, fieldNumber: 8)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Opentelemetry_Proto_Trace_V1_TraceConfig, rhs: Opentelemetry_Proto_Trace_V1_TraceConfig) -> Bool {
    if lhs.sampler != rhs.sampler {return false}
    if lhs.maxNumberOfAttributes != rhs.maxNumberOfAttributes {return false}
    if lhs.maxNumberOfTimedEvents != rhs.maxNumberOfTimedEvents {return false}
    if lhs.maxNumberOfAttributesPerTimedEvent != rhs.maxNumberOfAttributesPerTimedEvent {return false}
    if lhs.maxNumberOfLinks != rhs.maxNumberOfLinks {return false}
    if lhs.maxNumberOfAttributesPerLink != rhs.maxNumberOfAttributesPerLink {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_ConstantSampler: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ConstantSampler"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "decision"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularEnumField(value: &self.decision)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.decision != .alwaysOff {
      try visitor.visitSingularEnumField(value: self.decision, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Opentelemetry_Proto_Trace_V1_ConstantSampler, rhs: Opentelemetry_Proto_Trace_V1_ConstantSampler) -> Bool {
    if lhs.decision != rhs.decision {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_ConstantSampler.ConstantDecision: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "ALWAYS_OFF"),
    1: .same(proto: "ALWAYS_ON"),
    2: .same(proto: "ALWAYS_PARENT"),
  ]
}

extension Opentelemetry_Proto_Trace_V1_ProbabilitySampler: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ProbabilitySampler"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "samplingProbability"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularDoubleField(value: &self.samplingProbability)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.samplingProbability != 0 {
      try visitor.visitSingularDoubleField(value: self.samplingProbability, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Opentelemetry_Proto_Trace_V1_ProbabilitySampler, rhs: Opentelemetry_Proto_Trace_V1_ProbabilitySampler) -> Bool {
    if lhs.samplingProbability != rhs.samplingProbability {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Opentelemetry_Proto_Trace_V1_RateLimitingSampler: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".RateLimitingSampler"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "qps"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularInt64Field(value: &self.qps)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.qps != 0 {
      try visitor.visitSingularInt64Field(value: self.qps, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Opentelemetry_Proto_Trace_V1_RateLimitingSampler, rhs: Opentelemetry_Proto_Trace_V1_RateLimitingSampler) -> Bool {
    if lhs.qps != rhs.qps {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
