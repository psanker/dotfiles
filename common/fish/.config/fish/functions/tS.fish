function tS
    if test -n "$argv[1]"
        for i in (seq (count $argv))
            echo "task: stopping task ID '$argv[$i]'"
            task $argv[$i] stop
        end

        return
    end

    set -l active (task +ACTIVE ids | cut -d" " -f1)

    if test -z $active
        echo "Please provide a task ID(s) or set an active task"
        return
    end

    echo "task: stopping task ID '$active'"
    task $active stop
end

