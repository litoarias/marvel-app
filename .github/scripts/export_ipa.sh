#!/bin/bash

set -eo pipefail

xcodebuild -archivePath $PWD/build/MarvelApp.xcarchive \
            -exportOptionsPlist MarvelApp/MarvelApp/exportOptions.plist \
            -exportPath $PWD/build \
            -allowProvisioningUpdates \
            -exportArchive | xcpretty