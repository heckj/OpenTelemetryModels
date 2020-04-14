pushd opentelemetry-proto
FILES=$(find opentelemetry/proto/*/v1 -name "*.proto")

for FILE in ${FILES}
do
    protoc --swift_opt=FileNaming=DropPath --swift_opt=Visibility=Public --swift_out=../Sources/OpenTelemetryModels $FILE
done
popd
