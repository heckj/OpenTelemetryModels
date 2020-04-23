FROM swift:5.2
# concept borrowed from https://www.objc.io/blog/2018/08/28/testing-swift-on-linux/
# use:
#     docker build .
# to run the build and test...
WORKDIR /lib
COPY Package.swift ./
COPY Sources ./Sources
COPY Tests ./Tests
RUN swift test --enable-test-discovery
CMD ["echo hello"]
