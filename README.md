# OpenTelemetryModels

Swift Package wrapper around the OpenTelemetry models defined as protobufs

Uses the OpenTelemetry proto's from a submodule:

    brew install swift-protobuf
    git submodule update --init
    ./scripts/generate_sources.sh
    swift build
