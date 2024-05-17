#!/bin/bash

# Define pairs of directory names and their corresponding archives
declare -A archives
archives["results/compiledResults"]="results/compiledResults.tar.gz"
archives["data/controls"]="data/controls.tar.gz"
archives["scripts"]="scripts/scripts.tar.gz"

# Loop through each directory-archive pair
for dir in "${!archives[@]}"; do
    archive="${archives[$dir]}"

    # Check if the archive exists
    if [[ -f "$archive" ]]; then
        mkdir -p "$(dirname "$dir")"
        
        # Display the contents of the archive for debugging
        echo "Contents of $archive:"
        tar -tzf "$archive"

        # Extract the archive into the parent directory
        if tar -xzvf "$archive" -C "$(dirname "$dir")"; then
            echo "Successfully extracted $archive to $(dirname "$dir")"
        else
            echo "Failed to extract $archive" >&2
        fi
    else
        echo "Archive $archive not found" >&2
    fi
done
