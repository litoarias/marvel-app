#!/bin/sh
set -eo pipefail

echo "HELLO $IOS_KEYS"
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/DistributionProvisioningProfile.mobileprovision ./.github/secrets/DistributionProvisioningProfile.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/DistributionLito.p12 ./.github/secrets/DistributionLito.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/DistributionProvisioningProfile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/DistributionProvisioningProfile.mobileprovision


security create-keychain -p "" build.keychain
security import -P ./.github/secrets/DistributionLito.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain