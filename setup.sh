#!/bin/bash

# Define pairs of directory names and their corresponding archives
declare -A archives
archives["results/compiledResults"]="results/compiledResults.tar.gz"
archives["data/controls"]="data/controls.tar.gz"

# Loop through each directory-archive pair
for dir in "${!archives[@]}"; do
    archive="${archives[$dir]}"
    
    # Check if the directory exists
    if [ -d "$dir" ]; then
        echo "Directory '$dir' already exists."
    else
        echo "Directory '$dir' not found. Creating directory and extracting from archive '$archive'..."
        # Create the parent directory
        mkdir -p "$(dirname "$dir")"
        # Extract the archive into the parent directory
        tar -xzvf "$archive" -C "$(dirname "$dir")"
    fi
done
