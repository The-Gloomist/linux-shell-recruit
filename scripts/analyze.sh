#!/usr/bin/env bash

# Task 07: analyze the specified log file.
# Usage: ./scripts/analyze.sh FILE

# Validate arguments.
if [[ $# -ne 1 ]]; then
    echo "Usage: ./scripts/analyze.sh FILE"
    exit 1
fi

# Validate file existence.
file="$1"

if [[ ! -f "$file" ]]; then
    echo "Error: file not found: $file" >&2
    exit 1
fi

# Count ERROR entries.
error_count=$(grep -c "ERROR" "$file")

# Find the most frequent error code.
top_code=$(grep "ERROR" "$file" \
    | cut -d' ' -f5 \
    | cut -d'=' -f2 \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -1 \
    | awk '{print $2}')

# Print the analysis result.
echo "Total ERROR: $error_count"
echo "Top Code: $top_code"

exit 0
