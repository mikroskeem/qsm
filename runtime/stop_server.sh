mcserver_pid="$(get_pid)"
if is_server_running; then
    echo "sending stop"
    send_command "${stop_command:-stop}" || true

    echo "waiting for server"
    while (is_process_running "${mcserver_pid}"); do
        sleep 2
    done
else
    echo "server is not running"
fi

# vim: ft=sh: et: sw=4: sts=4
