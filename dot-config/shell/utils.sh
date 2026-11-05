#!/bin/sh

elzh_proxy() {
    case $1 in
        set)
            export https_proxy=localhost:7890
            export http_proxy=localhost:7890
            printf 'successfully set\n'
            ;;
        unset)
            unset https_proxy
            unset http_proxy
            printf 'successfully unset\n'
            ;;
        help | *)
            cat <<'EOF'
[USAGE]:     elzh_proxy [command]
    set  :        set `https_proxy` and `http_proxy` to localhost:7890.
    unset:        unset these env aforementioned.
    help :        print help information.
EOF
            ;;
    esac
}

ncd() {
    NVIM_CD_TMP=/tmp/nvim_cd nvim "$@"
    cd "$(cat /tmp/nvim_cd)"
}
