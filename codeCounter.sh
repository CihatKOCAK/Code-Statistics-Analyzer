continue=true

function Count-CodeLines {
    path=$1
    extensions=(".html" ".css" ".js" ".ts" ".jsx" ".tsx")

    totalFiles=0
    totalCodeLines=0

    for file in $(find "$path" -type f); do
        extension="${file##*.}"
        if [[ "${extensions[@]}" =~ "${extension}" ]] && [[ "$file" != *"node_modules"* ]]; then
            totalFiles=$((totalFiles + 1))
            codeLines=$(grep -v '^\s*$' "$file" | wc -l)
            totalCodeLines=$((totalCodeLines + codeLines))
        fi
    done

    echo "Total Number of Files --> $totalFiles"
    echo "Total Number of Code Lines --> $totalCodeLines"
}

while $continue; do
    read -p "Please enter the rootPath (e.g., /path/to/your/root/directory): " rootPath

    # Check if the rootPath corresponds to a Git repository
    if [ -d "$rootPath/.git" ]; then
        Count-CodeLines "$rootPath"
    else
        for projectFolder in "$rootPath"/*; do
            echo "Project Information for $(basename $projectFolder)"
            echo "--------------------------"
            Count-CodeLines "$projectFolder"
            echo ""
        done
    fi

    read -p "Press 'E' to exit or 'N' for a new rootPath, then press Enter: " choice
    if [[ $choice == "E" || $choice == "e" ]]; then
        continue=false
    fi
done
