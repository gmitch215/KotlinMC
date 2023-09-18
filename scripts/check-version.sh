#!/bin/bash

printf "[KotlinMC Version Checker]\n\n"

GREEN="\033[0;32m"
YELLOW="\033[0;33m"

api () {
  echo "https://api.github.com/repos/$1/releases/latest"
  return 0
}

auth="Authorization: Bearer $GITHUB_TOKEN"
tag_config='"tag_name": "\K.*?(?=")'

kotlin=$(curl -s "$(api "JetBrains/Kotlin")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
local_kotlin=$(cat versions/kotlin.txt)

printf "${GREEN}Latest Kotlin Version: %s\n" "$kotlin"
printf "${YELLOW}Local Kotlin Version: %s\n\n" "$local_kotlin"

kotlin_coroutines=$(curl -s "$(api "Kotlin/kotlinx.coroutines")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
local_kotlin_coroutines=$(cat versions/kotlinx-coroutines.txt)

printf "${GREEN}Latest Kotlin Coroutines Version: %s\n" "$kotlin_coroutines"
printf "${YELLOW}Local Kotlin Coroutines Version: %s\n\n" "$local_kotlin_coroutines"

kotlin_serialization=$(curl -s "$(api "Kotlin/kotlinx.serialization")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
local_kotlin_serialization=$(cat versions/kotlinx-serialization.txt)

printf "${GREEN}Latest Kotlin Serialization Version: %s\n" "$kotlin_serialization"
printf "${YELLOW}Local Kotlin Serialization Version: %s\n\n" "$local_kotlin_serialization"

kotlin_atomicfu=$(curl -s "$(api "Kotlin/kotlinx-atomicfu")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
local_kotlin_atomicfu=$(cat versions/kotlinx-atomicfu.txt)

printf "${GREEN}Latest Kotlin AtomicFU Version: %s\n" "$kotlin_atomicfu"
printf "${YELLOW}Local Kotlin AtomicFU Version: %s\n\n" "$local_kotlin_atomicfu"

kotlin_io=$(curl -s "$(api "Kotlin/kotlinx-io")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
local_kotlin_io=$(cat versions/kotlinx-io.txt)

printf "${GREEN}Latest Kotlin IO Version: %s\n" "$kotlin_io"
printf "${YELLOW}Local Kotlin IO Version: %s\n\n" "$local_kotlin_io"

upgrade=false

if [ ! "$local_kotlin" = "$kotlin" ] || [ ! "$local_kotlin_coroutines" = "$kotlin_coroutines" ] || [ ! "$local_kotlin_serialization" = "$kotlin_serialization" ] || [ ! "$local_kotlin_atomicfu" = "$kotlin_atomicfu" ] || [ ! "$local_kotlin_io" = "$kotlin_io" ]; then
    printf "${YELLOW}Updating is Required!\n"
    upgrade=true
fi

if [ "$upgrade" = "true" ]; then
  bash scripts/upgrade-versions.sh
else
  printf "${GREEN}No Update Required!\n"
fi
