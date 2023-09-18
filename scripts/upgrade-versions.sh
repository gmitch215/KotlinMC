#!/bin/bash

git config --global user.name 'github-actions[bot]'
git config --global user.email '41898282+github-actions[bot]@users.noreply.github.com'
git remote set-url origin "https://x-access-token:$GITHUB_TOKEN@github.com/GamerCoder215/KotlinMC"
git fetch origin master

api () {
  echo "https://api.github.com/repos/$1/releases/latest"
  return 0
}

auth="Authorization: Bearer $GITHUB_TOKEN"
tag_config='"tag_name": "\K.*?(?=")'

kotlin=$(curl -s "$(api "JetBrains/Kotlin")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
kotlin_coroutines=$(curl -s "$(api "Kotlin/kotlinx.coroutines")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
kotlin_serialization=$(curl -s "$(api "Kotlin/kotlinx.serialization")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
kotlin_atomicfu=$(curl -s "$(api "Kotlin/kotlinx-atomicfu")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)
kotlin_io=$(curl -s "$(api "Kotlin/kotlinx-io")" --header "$auth" | grep -Po "$tag_config" | cut -c2-)

echo "$kotlin" > versions/kotlin.txt
echo "$kotlin_coroutines" > versions/kotlinx-coroutines.txt
echo "$kotlin_serialization" > versions/kotlinx-serialization.txt
echo "$kotlin_atomicfu" > versions/kotlinx-atomicfu.txt
echo "$kotlin_io" > versions/kotlinx-io.txt

if [ "$(git status --porcelain)" ]; then
  git add versions/
  git commit -m "Update Kotlin Versions"
  git push -f origin master
  bash scripts/publish.sh
else
  echo "No changes detected"
fi

