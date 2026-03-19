function big --wraps="expac -H M '%m\\t%n' | sort -h | nl" --description "alias big=expac -H M '%m\\t%n' | sort -h | nl"
    expac -H M '%m\t%n' | sort -h | nl $argv
end
