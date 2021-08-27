#!/bin/sh

set -eo pipefail

sudo gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/DistributionProvisioningProfile.mobileprovision ./.github/secrets/DistributionProvisioningProfile.mobileprovision.gpg
sudo gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/DistributionLito.p12 ./.github/secrets/DistributionLito.p12.gpg

sudo mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

sudo cp ./.github/secrets/DistributionProvisioningProfile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/DistributionProvisioningProfile.mobileprovision


security create-keychain -p "" build.keychain
security import ./.github/secrets/DistributionLito.p12 -t agg -k ~/Library/Keychains/build.keychain -P "" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain