usage() {
    echo
    exit 1
}

cmd_wip() {
    if [ "$#" -lt 1 ]; then
        set_wip; exit 0
    elif [ "$#" -eq 1 ]; then
        case $1 in
            "-h"|"--help"|"help"|"h")
                usage; exit 0
                ;;
            "-r"|"--restore"|"r"|"restore")
                restore_wip; exit 0
                ;;
            "-c"|"--current"|"c"|"current")
                show_wip; exit 0
                ;;
        esac
    fi

    usage; exit 1
}

restore_wip() {
    # echo `git rev-parse --abbrev-ref HEAD`; exit 0
    from=`git @ wip -c`
    git @ branch $from
    git @ work
}

set_wip() {
    from=`git config at.wip`
    branch=`git @ branch`
    `git config --replace-all at.wip $branch`
    echo "wip updated to $branch from $from"
}

show_wip() {
    echo `git config at.wip`
}