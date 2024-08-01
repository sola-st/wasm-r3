#!/bin/bash

# Function to update and format index.html files
update_and_format_html() {
    local file="$1"
    local temp_file=$(mktemp)

    # Process the file and write to the temporary file
    awk '
    BEGIN {
        in_script = 0
        print "<!DOCTYPE html>"
        print "<html lang=\"en\">"
        print "<head>"
        print "    <meta charset=\"UTF-8\">"
        print "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
        print "    <title>WebAssembly Test</title>"
        print "</head>"
        print "<body>"
        print "    <script>"
    }
    /<script>/ { in_script = 1; next }
    /<\/script>/ { in_script = 0; next }
    in_script {
        if ($0 ~ /^export default async function test\(wasmBinary\) {/) {
            print "(async function(){"
        } else if ($0 ~ /let wasm = await WebAssembly\.instantiate\(wasmBinary, imports\)/) {
            print "    const indexResponse = await fetch(\"index.wasm\")"
            print "    const indexBinary = await indexResponse.arrayBuffer();"
            print "    let wasm = await WebAssembly.instantiate(indexBinary, imports)"
        } else if ($0 ~ /^}/) {
            print "})();"
        } else {
            print $0
        }
    }
    END {
        print "    </script>"
        print "</body>"
        print "</html>"
    }
    ' "$file" > "$temp_file"

    # Replace the original file with the modified content
    mv "$temp_file" "$file"

    # Apply Prettier to the file
    prettier --write "$file"

    echo "Updated and formatted: $file"
}

# Find and process all index.html files
find . -type f -name "index.html" | while read -r file; do
    update_and_format_html "$file"
done

echo "All index.html files have been updated and formatted."