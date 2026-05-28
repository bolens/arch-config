function gdv -w "git diff -w" -d "Pipe \`git diff\` through delta"
    git diff -w $argv | delta
end
