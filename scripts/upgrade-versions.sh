#!/bin/bash

git config --local user.email "action@github.com"
git config --local user.name "GitHub Action"
git fetch origin master

kotlin_untrimmed=$(curl -s "https://api.github.com/repos/JetBrains/kotlin/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" | grep -Po '"tag_name": "\K.*?(?=")')
kotlin=${kotlin_untrimmed#*v}

kotlin_coroutines_untrimmed=$(curl -s "https://api.github.com/repos/Kotlin/kotlinx.coroutines/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" | grep -Po '"tag_name": "\K.*?(?=")')
kotlin_coroutines=${kotlin_coroutines_untrimmed#*v}

kotlin_serialization_untrimmed=$(curl -s "https://api.github.com/repos/Kotlin/kotlinx.serialization/releases/latest" --header "Authorization: Bearer $GITHUB_TOKEN" | grep -Po '"tag_name": "\K.*?(?=")')
kotlin_serialization=${kotlin_serialization_untrimmed#*v}

echo "$kotlin" > versions/kotlin.txt
echo "$kotlin_coroutines" > versions/kotlinx-coroutines.txt
echo "$kotlin_serialization" > versions/kotlinx-serialization.txt

if [ "$(git status --porcelain)" ]; then
  git add versions/
  git commit -m "Update Kotlin Versions"
  git push
  bash scripts/publish.sh
else
  echo "No changes detected"
fi

