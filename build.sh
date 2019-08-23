#!/bin/bash

set -euo pipefail

SWIFT_SOURCE=/tmp/swift-source

cd $SWIFT_SOURCE
# If you change these flags, you will need to change the BUILD
# directory in the packaging script.
./swift/utils/build-script --release-debuginfo
