#!/bin/bash

set -euo pipefail

SWIFT_SOURCE=swift-source

cd $SWIFT_SOURCE
./swift/utils/build-script --release-debuginfo
