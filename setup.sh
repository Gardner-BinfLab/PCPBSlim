#!/bin/bash

# Define pairs of directory names and their corresponding archives
declare -A archives
archives["results/compiledResults"]="results/compiledResults.tar.gz"
archives["data/controls"]="data/controls.tar.gz"
archives["scripts"]="scripts/scripts.tar.gz"

# Loop through each directory-archive pair
for dir in "${!archives[@]}"; do
    archive="${archives[$dir]}"

    mkdir -p "$(dirname "$dir")"
    # Extract the archive into the parent directory
    tar -xzvf "$archive" -C "$(dirname "$dir")"
done
