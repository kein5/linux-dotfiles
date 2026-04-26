# Managed by chezmoi

set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx PAGER less
set -gx LESSHISTFILE -

if status is-interactive
    abbr -a ll 'ls -lah'
    abbr -a la 'ls -A'
    abbr -a gs 'git status -sb'
    abbr -a lg lazygit
    abbr -a zj zellij
    abbr -a tg topgrade

    function y --description 'Launch yazi and cd into the last directory'
        if not command -sq yazi
            echo 'yazi is not installed' >&2
            return 127
        end

        set -l tmp (mktemp)
        yazi $argv --cwd-file="$tmp"
        if test -f "$tmp"
            set -l cwd (cat "$tmp")
            rm -f "$tmp"
            if test -n "$cwd" -a -d "$cwd" -a "$cwd" != "$PWD"
                cd "$cwd"
            end
        end
    end

    if command -sq atuin
        atuin init fish | source
    end

    if command -sq starship
        starship init fish | source
    end

    if command -sq mise
        mise activate fish | source
    end
end

