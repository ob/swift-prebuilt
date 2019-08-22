[![Build Status](https://dev.azure.com/6f6231/swift-prebuilt/_apis/build/status/ob.swift-prebuilt?branchName=master)](https://dev.azure.com/6f6231/swift-prebuilt/_build/latest?definitionId=2&branchName=master)
# swift-prebuilt

Prebuilt version 5.0.1 of [apple/swift](https://github.com/apple/swift)

This repository compiles [Swift](https://github.com/apple/swift) and packages the resulting intermediate directories for direct consumption. The idea is to avoid compiling swift in projects that depepend on it.

It also packages some useful utilities from the Swift compiler to be used by [this homebrew tap](https://github.com/ob/homebrew-tools/blob/master/README.md).
