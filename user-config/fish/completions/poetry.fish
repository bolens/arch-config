function __fish_poetry_97e6c269c9439129_complete_no_subcommand
    for i in (commandline -opc)
        if contains -- $i about add build cache check config debug env export help init install list lock new publish python remove run search self show source sync update version
            return 1
        end
    end
    return 0
end

# global options
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l ansi -d 'Force ANSI output.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l directory -d 'The working directory for the Poetry command (defaults to the current working directory). All command-line arguments will be resolved relative to the given directory.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l help -d 'Display help for the given command. When no command is given display help for the list command.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l no-ansi -d 'Disable ANSI output.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l no-cache -d 'Disables Poetry source caches.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l no-interaction -d 'Do not ask any interactive question.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l no-plugins -d 'Disables plugins.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l project -d 'Specify another path as the project root. All command-line arguments will be resolved relative to the current working directory.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l quiet -d 'Do not output any message.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l verbose -d 'Increase the verbosity of messages: 1 for normal output, 2 for more verbose output and 3 for debug.'
complete -c poetry -n '__fish_poetry_97e6c269c9439129_complete_no_subcommand' -l version -d 'Display this application version.'

# ...rest of poetry completions content...
