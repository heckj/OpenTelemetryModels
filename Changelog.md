# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

This project is based on [OpenTelemetry](https://github.com/open-telemetry/opentelemetry-specification/blob/master/README.md),
and major versions will track compatibility with that specification.

## [Unreleased]

### Added

- Event added timestamp computed property returning Date()

### Changed

### Fixed

## [0.3.0] - 2020-04-25

### Added

- conveniences for creating Span, Attribute, and Event
- hexEncoding extension on Data for generating hex-strings from data buffers
- SpanID and TraceID representing the raw buffer IDs
- SpanID conforms to CustomStringConvertible and CustomDebugStringConvertible
- TraceID conforms to CustomStringConvertible and CustomDebugStringConvertible
- Span subscript access reads Attributes
- Event subscript access reads Attributes
- Span added startDate computed property returning Date()
- Span added endDate computed property returning Date()? if date > 0

### Changed

- aliasing from protobuf generated models to OpenTelemetry namespace
- Attribute conforms to CustomStringConvertible and CustomDebugStringConvertible
- Event conforms to CustomStringConvertible and CustomDebugStringConvertible
- Span conforms to CustomStringConvertible and CustomDebugStringConvertible
- Span initializer sets values, optionally including attributes
- Event initializer sets values, optionally including attributes

### Fixed

- convenience for adding attributes to Event and Span acts like a dict/map
  (no duplicate key names are allowed).