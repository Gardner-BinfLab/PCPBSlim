#!/bin/bash

# Define pairs of directory names and their corresponding archives
declare -A archives
archives["compiledResults"]="results/compiledResults.tar.gz"
archives["controls"]="data/controls.tar.gz"

# Loop through each directory-archive pair
for dir in "${!archives[@]}"; do
    archive="${archives[$dir]}"
    
    # Check if the directory exists
    if [ -d "$dir" ]; then
        echo "Directory '$dir' already exists."
    else
        echo "Directory '$dir' not found. Creating directory and extracting from archive '$archive'..."
        # Create the directory
        mkdir -p "$dir"
        # Extract the archive into the directory
        tar -xzvf "$archive" -C "$dir"
    fi
done
