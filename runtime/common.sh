set -u

check_boot_flag() {
    if [ -f "${server_dir}/.dontboot "]; then
        echo "${server_dir}/.dontboot exists, not booting the server"
        exit 0
    fi
}

get_pid () {
    cat "${server_dir}/server.pid" 2>/dev/null || true
}

is_process_running () {
    kill -0 "${1}" 2>/dev/null
}

is_server_running () {
    local mcserver_pid
    mcserver_pid="$(get_pid)"
    [ -n "${mcserver_pid}" ] && is_process_running "${mcserver_pid}"
}

send_command () {
    if (is_server_running); then
        pushd /home/mark/async-mcrcon >/dev/null
        python rcon.py ${@}
        popd >/dev/null
    else
        echo "server is not running"
    fi
}

# vim: ft=sh: et: sw=4: sts=4
