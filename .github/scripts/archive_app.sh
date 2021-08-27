#!/bin/bash

set -eo pipefail

xcodebuild -workspace MarvelApp.xcworkspace \
            -scheme MarvelApp-Release \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/MarvelApp.xcarchive \
            clean archive | xcpretty