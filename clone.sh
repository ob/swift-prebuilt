#!/bin/bash

set -euo pipefail

SWIFT_VERSION=$(cat SWIFT-VERSION)

mkdir swift-source
cd swift-source
git clone https://github.com/apple/swift.git
./swift/utils/update-checkout --clone --tag "$SWIFT_VERSION"
