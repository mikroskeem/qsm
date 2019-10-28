#!/bin/sh

set -e

# {{{
# Load configuration and runtime
get_script_path () {
    local script_dir
    local basedir

    script_dir="$(dirname "${0}")"
    pushd "${script_dir}" >/dev/null
    basedir="$(/usr/bin/pwd -P)"
    popd >/dev/null
    echo "${basedir}"
}

basedir="${basedir:-$(get_script_path)}"
if [ -z "${basedir}" ]; then
    echo "could not figure out the script base dir!"
    exit 1
fi
export basedir

. "${basedir}/runtime/common.sh"
. "${basedir}/config.sh"
# Load configuration END
# }}}

first="${1}"
shift

case "${first}" in
    start)
        . "${basedir}/runtime/start_server.sh"
        ;;
    stop)
        . "${basedir}/runtime/stop_server.sh"
        ;;
#    launch)
#        sh "${basedir}/runtime/launch.sh"
#        ;;
    command)
        . "${basedir}/runtime/send_cmd.sh"
        ;;
    *)
        echo "usage: idk"
        ;;
esac

# vim: ft=sh: et: sw=4: sts=4
