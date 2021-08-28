#!/bin/bash

set -eo pipefail

#check if env-vars.sh exists
echo "$PWD/env-vars.sh"

if [ -f $PWD/env-vars.sh ]
then
echo "I am here"
source $PWD/env-vars.sh
fi

#no `else` case needed if the CI works as expected
$PWD/Pods/Sourcery/bin/sourcery --templates $PWD/MarvelApp --sources $PWD --output $PWD/MarvelApp/Stuff/Environment --args publicApiKey=$MARVEL_PUBLIC_API_KEY,privateApiKey=$MARVEL_PRIVATE_API_KEY


xcodebuild -workspace MarvelApp.xcworkspace  \
           -scheme MarvelApp-Release \
           build

xcodebuild -workspace MarvelApp.xcworkspace \
            -scheme MarvelApp-Release \
            -sdk iphoneos \
            -configuration AppStoreDistribution \
            -archivePath $PWD/build/MarvelApp.xcarchive \
            clean archive | xcpretty