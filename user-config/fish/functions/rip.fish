function rip --wraps="expac --timefmt='%Y-%m-%d %T' '%l\\t%n %v' | sort | tail -200 | nl" --description "alias rip=expac --timefmt='%Y-%m-%d %T' '%l\\t%n %v' | sort | tail -200 | nl"
    expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl $argv
end
