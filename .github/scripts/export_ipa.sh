#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/MarvelApp.xcarchive \
            -exportOptionsPlist MarvelApp/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty