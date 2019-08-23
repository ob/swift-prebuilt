#!/bin/bash

set -euo pipefail

V=-v

SWIFT_SOURCE=/tmp/swift-source
RELEASE=release
mkdir -p $RELEASE

case `uname -s` in
    Darwin)
        OS=macosx
        ;;
    *)
        echo Unsupported OS
        exit 1
esac

CPU=$(uname -m)
BUILD=$SWIFT_SOURCE/build/Ninja-RelWithDebInfoAssert/

# create the packages
PACKAGES=(
    llvm
    swift
)

for package in ${PACKAGES[@]}
do
    tar -c $V -f $RELEASE/${package}-${OS}-${CPU}.tar.lrzip \
        -C $BUILD \
        --exclude '*.o' --exclude '*.tmp' \
        --use-compress-program lrzip \
        ${package}-${OS}-${CPU}
done

# now do the small utilities package
TOOLS=tools
mkdir -p $TOOLS/bin

SWIFT_TOOLS=($(cat SWIFT-TOOLS))
CLANG_TOOLS=($(cat CLANG-TOOLS))

echo Packaging Swift Tools
for tool in ${SWIFT_TOOLS[@]}
do
    cp $BUILD/swift-${OS}-${CPU}/bin/$tool $TOOLS/bin
done
echo Packaging Clang Tools
for tool in ${CLANG_TOOLS[@]}
do
    cp $BUILD/llvm-${OS}-${CPU}/bin/$tool $TOOLS/bin
done

tar $V -c -f $RELEASE/tools-${OS}-${CPU}.tar.gz -y tools

# Compute checksums
cd $RELEASE
FILES=$(ls)
echo '```' > checksums.md
for tb in ${FILES}
do
    shasum -a 256 $tb >> checksums.md
done
echo '```' >> checksums.md
mv checksums.md ..
