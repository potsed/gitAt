usage() {
    cat <<'EOF'

          __                                                 __
       __/\ \__          __                                 /\ \
   __ /\_\ \ ,_\        /'_`\_      __  __  __    ___   _ __\ \ \/'\
 /'_ `\/\ \ \ \/       /'/'_` \    /\ \/\ \/\ \  / __`\/\`'__\ \ , <
/\ \L\ \ \ \ \ \_     /\ \ \L\ \   \ \ \_/ \_/ \/\ \L\ \ \ \/ \ \ \\`\
\ \____ \ \_\ \__\    \ \ `\__,_\   \ \___x___/'\ \____/\ \_\  \ \_\ \_\
 \/___L\ \/_/\/__/     \ `\_____\    \/__//__/   \/___/  \/_/   \/_/\/_/
   /\____/              `\/_____/
   \_/__/

EOF
    echo 'Usage: git @ work'
    exit 0
}

cmd_work() {
    # git @ stop
    local current=`git @ branch -c`
    local branch=`git @ branch`
    local STASHKEY='autostash-work-branch'
    if [ "$current" == "$branch" ]; then
        # git @ start
        echo "You're already in the working branch"
        echo
        exit 1;
    fi

    echo 'Fetching branches'
    git fetch;

    echo 'Stashing Changes'
    git stash -m $STASHKEY;

    local HAS_STASH=`git stash list | grep 'test' | wc -l | tr -d ' '`

    if [ ! `git branch --list $branch` ]; then

        echo 'Switching to and updating develop branch'
        git checkout develop;
        git pull;

        echo 'Creating local branch from updated dev branch'
        git branch $branch;
    fi;

    echo 'Switching to local branch'
    git checkout $branch

    echo 'Reapplying stashed changes'
    if [ "$HAS_STASH" == "1" ]; then
        git stash pop;
    fi;

    exit 1;
}
