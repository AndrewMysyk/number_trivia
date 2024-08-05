#!/usr/bin/env sh

set -e # Exit on first failed command

# Variables
LOCO_EXPORT_KEY="bVXjokiI5UW5P6wLyfpCN1EZF7gV8dWy"

curl -s -o "translated.zip" "https://localise.biz/api/export/archive/arb.zip?key=$LOCO_EXPORT_KEY"
unzip -qq "translated.zip" -d "l10n"

# Rename localizations files
mv l10n/number-trivia-arb-archive/l10n/intl_messages_en_UK.arb l10n/number-trivia-arb-archive/l10n/intl_en.arb

# Move localizations files to lib/l10n directory
mv l10n/number-trivia-arb-archive/l10n/intl_en.arb lib/l10n

# Cleanup
rm translated.zip
rm -rf l10n-translated
rm -rf l10n-input
rm -rf l10n