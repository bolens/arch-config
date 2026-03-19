function hw --wraps='hwinfo --short' --wraps='inxi -S' --description 'alias hw=inxi -S'
    inxi -S $argv
end
