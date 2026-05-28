function untar --wraps='tar -xvf ' --description 'alias untar=tar -xvf '
    tar -xvf $argv
end
