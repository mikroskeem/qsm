if (is_server_running); then
    echo "ERROR: server is already running!"
    exit 1
fi

systemd-run \
    --scope \
    --slice mcserver.slice \
    -E basedir="${basedir}" \
    tmux new-session -d -s mcserver "${basedir}/runtime/launch.sh"

# TODO: systemd-run sucks and is limited as fuck
#    --property=ExecStop='/home/mark/mcserver/running_scripts/shutdown_server.sh' \
#    --property=ExecStopPost='/home/mark/running_scripts/post_shutdown.sh' \

# wait until server is up
sleep 1
echo "waiting until server starts up"
mcserver_pid="$(get_pid)"
current_ts="$(date +%s)"

while true; do
    if (is_process_running "${mcserver_pid}"); then
        # check if log file is rotated first - some servers might start up slow
        # TODO: this check is shit
        if [ "$(stat -c %Y "${server_dir}/logs/latest.log")" -gt "${current_ts}" ] && (grep -q 'Done (.*)! For help, type "help" or "?"' "${server_dir}/logs/latest.log"); then
            echo "server is running, exiting"
            exit 0
        fi
    else
        echo "server died unexpectedly!"
        exit 1
    fi
    sleep 2
done


# vim: ft=sh: et: sw=4: sts=4
