#!/bin/bash

# Define pairs of directory names and their corresponding archives
declare -A archives
archives["compiledResults"]="compiledResults.tar.gz"
archives["controls"]="controls.tar.gz"

# Loop through each directory-archive pair
for dir in "${!archives[@]}"; do
    archive="${archives[$dir]}"
    
    # Check if the directory exists
    if [ -d "$dir" ]; then
        echo "Directory '$dir' already exists."
    else
        echo "Directory '$dir' not found. Extracting from archive '$archive'..."
        # Extract the archive since the directory doesn't exist
        tar -xzvf "$archive"
    fi
done
