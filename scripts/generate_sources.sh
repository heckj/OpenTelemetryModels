pushd opentelemetry-proto
FILES=$(find opentelemetry/proto/*/v1 -name "*.proto")

for FILE in ${FILES}
do
    protoc --swift_out=../Sources/OpenTelemetryModels $FILE
done
popd
