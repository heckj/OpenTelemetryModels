# OpenTelemetryModels

Swift Package wrapper around the OpenTelemetry models defined as protobufs

## checkout, build, and test

This project uses OpenTelemetry protobuf definitions from a submodule:

    brew install swift-protobuf
    git submodule update --init
    ./scripts/generate_sources.sh
    swift test

## Goals for this project

The structures in this project are aimed at representing traces, assocaited attributes,
events, timestamps, and IDs. This library aims to make creating and inspecting these objects
possible in the swift language, as well as doing some basic serialization and deserialization
leveraging the protobuf based models and the
[swift-protobuf](https://github.com/apple/swift-protobuf) project.

As a general goal, the project aims to not rely on any Apple specific libraries, and to be usable
on any platform supported by swift. In practice it is being developed first on macOS and
actively used on some of the common Apple product lines (iOS, macOS, and tvOS). The
project will be supporting [SwiftPM](https://swift.org/package-manager/) as the primary
means of using or consuming it.

In order to match the conceptual models inside other OpenTelemetry
implementations, the models have aliasing in names, extensions on them to implement the
expected functionality and convenience structures for digging into the data itself.

Tests and documentation are being added, and CI enabled, for these additions, and are
expected to cover the conveniences and pass before any updates are merged. Test coverage
is being tracked and [can be viewed on CodeCov](https://codecov.io/gh/heckj/OpenTelemetryModels/).

### Possible future goals

As OpenTelemetry (or yet another possible successor) evolves and matures and if interop
testing becomes available, this project may leverage it. It may also implement some form of this
testing, so that the cross-platform data transfer and conceptual structures can be verified
as compatible.

## Documentation

Documentation of the project is available in [this project's github
wiki](https://github.com/heckj/OpenTelemetryModels/wiki), updated by the CI system
on merges to master.

## Contributing

Contributions are welcome, and nothing here is a sacred animal. Tests and documentation
are expected, as is some alignment to the goals above.

### WTF Background

This started out as a bit of exploratory work as the conceptual idea of "Traces" matched a use
case I wanted to pursue, but wasn't the classic "distributed tracing" kind of mechanism.

As such, if you're using this repo, be aware that this **is not** an OpenTelemetry tracing
implementation. In their parlance, this project doesn't conform to the OpenTelemetry API at all.
Instead it focuses on the low-level elements that might be used to create an SDK to go along
with an API implementation. Look into the [OpenTelemetry Library
Guidelines](https://github.com/open-telemetry/opentelemetry-specification/blob/master/specification/library-guidelines.md)
for more details on API, SDK, and how they view these things being structured and related.
There is a "formal" swift OpenTelemetry API that is being created at
<https://github.com/open-telemetry/opentelemetry-swift>.

The inception of this project started from the models first, with a (quite possibly naive) hope
that if the base models were used, the data itself might be able to be re-used and effectively
imported into systems that understand OpenTelemetry traces, metrics, etc. This project is
(as of April 2020) unlikely to grow to a full OpenTelemetry 'SDK' project, but might be useful in
creating such an SDK.

Since I started this thing, my perception is that OpenTelemetry is a sort of "stew pot project"
for tracing implementations - and while there's a specification, there isn't any formal interop
testing, benchmarks, or structures beyond a high level concept of Collector, along with details
for some possible [future vision of the
Collector](https://github.com/open-telemetry/opentelemetry-swift). The protobuf data models
are defined for cross language, and cross platform, interoperabiity - and that makes up the
underlying data models in this project.

## Using OpenTelemetryModels

**reminder**: This is **NOT** a full tracer library implementation, and doesn't do anthing
about storing, transfering, or sampling for the underlying models. The
convenience methods in this library are about creating, inspecting, and
manipulating trace spans directly.

To run the doctest on the README: `swift doctest --package README.md`
(use `swift run --repl` to run these interactively)


```swift doctest
import OpenTelemetryModels

let span = OpenTelemetry.Span("foo")
span.name // => String = "foo"
```


