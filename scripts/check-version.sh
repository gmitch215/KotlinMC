#!/bin/bash

printf "[KotlinMC Version Checker]\n\n"

GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RESET="\033[0m"

api () {
  echo "https://api.github.com/repos/$1/releases/latest"
  return 0
}

auth="Authorization: Bearer $GITHUB_TOKEN"
tag_config='"tag_name": "\K.*?(?=")'
upgrade=false

kotlin=$(curl -s "$(api "JetBrains/Kotlin")" --header "$auth" | grep -Po "$tag_config" | cut -d "v" -f2-)
local_kotlin=$(cat versions/kotlin.txt | xargs | tr -d '\r\n')

if [ "$local_kotlin" = "$kotlin" ]; then
  kotlin_diff="v$kotlin"
else
  kotlin_diff="v$local_kotlin -> v$kotlin"
  upgrade=true
fi

printf "${GREEN}Latest Kotlin Version: %s${RESET}\n" "$kotlin"
printf "${YELLOW}Local Kotlin Version: %s${RESET}\n\n" "$local_kotlin"

kotlin_coroutines=$(curl -s "$(api "Kotlin/kotlinx.coroutines")" --header "$auth" | grep -Po "$tag_config" | cut -d "v" -f2-)
local_kotlin_coroutines=$(cat versions/kotlinx-coroutines.txt | xargs | tr -d '\r\n')

if [ "$local_kotlin_coroutines" = "$kotlin_coroutines" ]; then
  kotlin_coroutines_diff="v$kotlin_coroutines"
else
  kotlin_coroutines_diff="v$local_kotlin_coroutines -> v$kotlin_coroutines"
  upgrade=true
fi

printf "${GREEN}Latest Kotlin Coroutines Version: %s${RESET}\n" "$kotlin_coroutines"
printf "${YELLOW}Local Kotlin Coroutines Version: %s${RESET}\n\n" "$local_kotlin_coroutines"

kotlin_serialization=$(curl -s "$(api "Kotlin/kotlinx.serialization")" --header "$auth" | grep -Po "$tag_config" | cut -d "v" -f2-)
local_kotlin_serialization=$(cat versions/kotlinx-serialization.txt | xargs | tr -d '\r\n')

if [ "$local_kotlin_serialization" = "$kotlin_serialization" ]; then
  kotlin_serialization_diff="v$kotlin_serialization"
else
  kotlin_serialization_diff="v$local_kotlin_serialization -> v$kotlin_serialization"
  upgrade=true
fi

printf "${GREEN}Latest Kotlin Serialization Version: %s${RESET}\n" "$kotlin_serialization"
printf "${YELLOW}Local Kotlin Serialization Version: %s${RESET}\n\n" "$local_kotlin_serialization"

kotlin_atomicfu=$(curl -s "$(api "Kotlin/kotlinx-atomicfu")" --header "$auth" | grep -Po "$tag_config" | cut -d "v" -f2-)
local_kotlin_atomicfu=$(cat versions/kotlinx-atomicfu.txt | xargs | tr -d '\r\n')

if [ "$local_kotlin_atomicfu" = "$kotlin_atomicfu" ]; then
  kotlin_atomicfu_diff="v$kotlin_atomicfu"
else
  kotlin_atomicfu_diff="v$local_kotlin_atomicfu -> v$kotlin_atomicfu"
  upgrade=true
fi

printf "${GREEN}Latest Kotlin AtomicFU Version: %s${RESET}\n" "$kotlin_atomicfu"
printf "${YELLOW}Local Kotlin AtomicFU Version: %s${RESET}\n\n" "$local_kotlin_atomicfu"

kotlin_io=$(curl -s "$(api "Kotlin/kotlinx-io")" --header "$auth" | grep -Po "$tag_config" | cut -d "v" -f2-)
local_kotlin_io=$(cat versions/kotlinx-io.txt | xargs | tr -d '\r\n')

printf "${GREEN}Latest Kotlin IO Version: %s${RESET}\n" "$kotlin_io"
printf "${YELLOW}Local Kotlin IO Version: %s${RESET}\n\n" "$local_kotlin_io"

if [ "$local_kotlin_io" = "$kotlin_io" ]; then
  kotlin_io_diff="v$kotlin_io"
else
  kotlin_io_diff="v$local_kotlin_io -> v$kotlin_io"
  upgrade=true
fi

kotlin_datetime=$(curl -s "$(api "Kotlin/kotlinx-datetime")" --header "$auth" | grep -Po "$tag_config" | cut -d "v" -f2-)
local_kotlin_datetime=$(cat versions/kotlinx-datetime.txt | xargs | tr -d '\r\n')

printf "${GREEN}Latest Kotlin DateTime Version: %s${RESET}\n" "$kotlin_datetime"
printf "${YELLOW}Local Kotlin DateTime Version: %s${RESET}\n\n" "$local_kotlin_datetime"

if [ "$local_kotlin_datetime" = "$kotlin_datetime" ]; then
  kotlin_datetime_diff="v$kotlin_datetime"
else
  kotlin_datetime_diff="v$local_kotlin_datetime -> v$kotlin_datetime"
  upgrade=true
fi

if [ "${upgrade}" = "true" ]; then
    printf "${YELLOW}Updating is Required!${RESET}\n"
    upgrade=true

    # Create Changelog
    header="# KotlinMC v${kotlin}\n\n"
    kotlin_changelog="- \`kotlin-stdlib\` / \`kotlin-reflect\` ${kotlin_diff}\n"
    kotlinx_coroutines_changelog="- \`kotlinx-coroutines\` ${kotlin_coroutines_diff}\n"
    kotlinx_serialization_changelog="- \`kotlinx-serialization\` ${kotlin_serialization_diff}\n"
    kotlinx_atomicfu_changelog="- \`kotlinx-atomicfu\` ${kotlin_atomicfu_diff}\n"
    kotlinx_io_changelog="- \`kotlinx-io\` ${kotlin_io_diff}\n"
    kotlinx_datetime_changelog="- \`kotlinx-datetime\` ${kotlin_datetime_diff}\n"

    changelog_end="\n## [View on GitHub](https://github.com/gmitch215/KotlinMC)"

    changelog="${header}${kotlin_changelog}${kotlinx_coroutines_changelog}${kotlinx_serialization_changelog}${kotlinx_atomicfu_changelog}${kotlinx_io_changelog}${kotlinx_datetime_changelog}${changelog_end}"
    echo -e $changelog > CHANGELOG.md

    bash scripts/upgrade-versions.sh
else
  printf "${GREEN}No Update Required!${RESET}\n"
fi
