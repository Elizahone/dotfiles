#!/bin/bash

function elzh_proxy() {
    case $1 in
        'set')
            export https_proxy=localhost:7890 &&
            export http_proxy=localhost:7890 &&
            echo "sucessfully set\n"
            ;;
        'unset')
            unset https_proxy
            unset http_proxy
            echo "sucessfully unset\n"
            ;;
        'help')
        echo -e \
        '[USAGE]:     elzh_proxy [command]
    set  :        set `https_proxy` and `http_proxy` to localhost:7890.
    unset:        unset these env aforementioned.
    help :        print help information.'
            ;;
        *)
        echo -e \
        '[USAGE]:     elzh_proxy [command]
    set  :        set `https_proxy` and `http_proxy` to localhost:7890.
    unset:        unset these env aforementioned.
    help :        print help information.'
            ;;
    esac
}

function ncd() {
    NVIM_CD_TMP=/tmp/nvim_cd nvim "$@"
    cd $(cat /tmp/nvim_cd)
}
