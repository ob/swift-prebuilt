#!/bin/bash

set -euo pipefail

V=-v

SWIFT_SOURCE=swift-source
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

TARBALLS=()
for package in ${PACKAGES[@]}
do
    TB=${package}-${OS}-${CPU}.tar.gz
    tar -c $V -f - \
        -C $BUILD --exclude '*.o' ${package}-${OS}-${CPU} \
    | pigz > $RELEASE/$TB
    TARBALLS+=( $TB )
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

TB=tools-${OS}-${CPU}.tar.gz
tar $V -c -f - tools | pigz > $RELEASE/$TB
TARBALLS+=( $TB )

# Compute checksums
cd $RELEASE
echo '```' > checksums.md
for tb in ${TARBALLS[@]}
do
    shasum -a 256 $tb >> checksums.md
done
echo '```' >> checksums.md
