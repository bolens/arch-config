function gignored -d "list temporarily ignored files"
    git ls-files -v | rg "^[[:lower:]]" $argv
end
