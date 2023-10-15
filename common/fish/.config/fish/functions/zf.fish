function zf
    set -l dir "."

    if test -n "$argv[1]"
        set dir $argv[1]
    end

    set -l pdf (find "$dir" -name "*.pdf" -mindepth 1 -maxdepth 3 | fzf)

    if test $status -eq 0
        sioyek "$pdf"
    end
end
