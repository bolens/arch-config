function untar --wraps='tar -zxvf ' --description 'alias untar=tar -zxvf '
    tar -zxvf  $argv
end
