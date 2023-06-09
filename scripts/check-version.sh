#!/bin/bash

printf "[KotlinMC Version Checker]\n\n"

GREEN="\033[0;32m"
YELLOW="\033[0;33m"

kotlin_untrimmed=$(curl -s "https://api.github.com/repos/JetBrains/kotlin/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" | grep -Po '"tag_name": "\K.*?(?=")')
kotlin=${kotlin_untrimmed#*v}
local_kotlin=$(cat versions/kotlin.txt)

printf "${GREEN}Latest Kotlin Version: %s\n" "$kotlin"
printf "${YELLOW}Local Kotlin Version: %s\n\n" "$local_kotlin"

kotlin_coroutines_untrimmed=$(curl -s "https://api.github.com/repos/Kotlin/kotlinx.coroutines/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" | grep -Po '"tag_name": "\K.*?(?=")')
kotlin_coroutines=${kotlin_coroutines_untrimmed#*v}
local_kotlin_coroutines=$(cat versions/kotlinx-coroutines.txt)

printf "${GREEN}Latest Kotlin Coroutines Version: %s\n" "$kotlin_coroutines"
printf "${YELLOW}Local Kotlin Coroutines Version: %s\n\n" "$local_kotlin_coroutines"

kotlin_serialization_untrimmed=$(curl -s "https://api.github.com/repos/Kotlin/kotlinx.serialization/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" | grep -Po '"tag_name": "\K.*?(?=")')
kotlin_serialization=${kotlin_serialization_untrimmed#*v}
local_kotlin_serialization=$(cat versions/kotlinx-serialization.txt)

printf "${GREEN}Latest Kotlin Serialization Version: %s\n" "$kotlin_serialization"
printf "${YELLOW}Local Kotlin Serialization Version: %s\n\n" "$local_kotlin_serialization"

upgrade=false

if [ ! "$local_kotlin" = "$kotlin" ] || [ ! "$local_kotlin_coroutines" = "$kotlin_coroutines" ] || [ ! "$local_kotlin_serialization" = "$kotlin_serialization" ]; then
    printf "${YELLOW}Updating is Required!\n"
    upgrade=true
fi

if [ "$upgrade" = "true" ]; then
  bash ../scripts/upgrade-versions.sh
else
  printf "${GREEN}No Update Required!\n"
fi