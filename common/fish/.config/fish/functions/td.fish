function td
    if test -n "$argv[1]"
        for i in (seq (count $argv))
            echo "task: marking task ID '$argv[$i]' done"
            task $argv[$i] done
        end

        return
    end

    set -l active (task +ACTIVE ids | cut -d" " -f1)

    if test -z $active
        echo "Please provide a task ID(s) or set an active task"
        return
    end

    echo "task: marking task ID '$active' done"
    task $active done
end
