#!/bin/bash

set -x

set -euo pipefail

SWIFT_VERSION=$(cat SWIFT-VERSION)
SWIFT_SOURCE=/tmp/swift-source

mkdir $SWIFT_SOURCE
cd $SWIFT_SOURCE
git clone https://github.com/apple/swift.git
./swift/utils/update-checkout --clone --tag "$SWIFT_VERSION"
