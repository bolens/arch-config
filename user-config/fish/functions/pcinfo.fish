function pcinfo --wraps='inxi -Fxxxz' --description 'alias pcinfo=inxi -Fxxxz'
    inxi -Fxxxz $argv
end
