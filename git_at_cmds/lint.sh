usage() {
    echo 'Usage: git @ lint /path/to/lint/relative/to/app/root'
    echo 'Set the lint tool: git @ lint -t [/path/to/tool in relation to app root eg: /vendor/squizlabs/php_codesniffer/bin/phpcs]'
    exit 1
}

cmd_lint() {
    if [ "$#" -lt 1 ]; then
        usage; exit 1;
    elif [ "$#" -lt 2 ]; then
        case $1 in
            "-t"|"--tool"|"tool"|"t")
                show_tool; exit 0
                ;;
            "-h"|"--help"|"help"|"h")
                usage; exit 0
                ;;
            *)
                run_linter $1; exit 0
                ;;
        esac
    else
        case $1 in
            "-t"|"--tool"|"tool"|"t")
                set_tool $2; exit 0
                ;;
            "-h"|"--help"|"help"|"h")
                usage; exit 0
                ;;
        esac
    fi
    usage; exit 1
}

run_linter() {
    local theTOOL=`git config at.linter`
    local thePWD=`pwd`
    local root=`git @ root`
    # local message="$@ - "`git @ label`

    # cd $root;

    thePATH="$root$1";
    theCMD="$root$theTOOL"
    echo "Linting: $thePATH";
    $theCMD $thePATH;
    exit 1;
}

set_tool() {
    `git config --replace-all at.linter $1`
    echo 'Lint tool updated'
    show_tool; exit 1
}

show_tool() {
    echo "Current Lint Tool "`git config at.linter`
    echo
    exit 1
}