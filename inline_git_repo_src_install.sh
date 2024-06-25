#!/bin/bash

# Search Github API repositories for any package in any language and install it.

read -p "package name: " pkg
read -p "language name: " lng
url="https://api.github.com/search/repositories?q=$pkg+language:$lng"
response=$(curl -s "$url")
titles=$(echo "$response" | jq -r '.items[].name')
descriptions=$(echo "$response" | jq -r '.items[].description')
urls=$(echo "$response" | jq -r '.items[].html_url')
for i in "${!titles[@]}"
do
  printf "%s\n%s\n%s\n\n" "${titles[$i]}" "${descriptions[$i]}" "${urls[$i]}"
done

for url in "${urls[@]}"
do
  sudo git clone "$url" "/opt/$(basename $url .git)"
done
  
