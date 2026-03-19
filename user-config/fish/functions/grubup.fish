function grubup --wraps='sudo grub-mkconfig -o /boot/grub/grub.cfg' --description 'alias grubup=sudo grub-mkconfig -o /boot/grub/grub.cfg'
    sudo grub-mkconfig -o /boot/grub/grub.cfg $argv
end
