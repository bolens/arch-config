function psmem --description 'List processes sorted by memory usage'
    ps auxf | sort -nr -k 4
end
