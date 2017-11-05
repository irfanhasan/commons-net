#!/bin/sh

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

while true
do
    if [ $LOCAL = $REMOTE ]; then
        echo "Up-to-date"
    elif [ $LOCAL = $BASE ]; then
        echo "Need to pull"
        git pull upstream trunk
        git push origin trunk
    elif [ $REMOTE = $BASE ]; then
        echo "Need to push"
    else
        echo "Diverged"
    fi
    sleep 7200 #2 hours
done
