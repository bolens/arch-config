function psmem10 --description 'Top 10 processes by memory usage'
    ps auxf | sort -nr -k 4 | head -10
end
