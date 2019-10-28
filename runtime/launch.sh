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

    # Fixup basedir for this script
    basedir="${basedir}/.."

    popd >/dev/null
    echo "${basedir}"
}

basedir="${basedir:-$(get_script_path)}"
if [ -z "${basedir}" ]; then
    echo "could not figure out the script base dir!"
    exit 1
fi

. "${basedir}/runtime/common.sh"
. "${basedir}/config.sh"
# Load configuration END
# }}}

cd "${server_dir}" || exit 1
echo "${$}" > server.pid

exec "${jvm}" ${jvm_args:-} -jar "${server_jar}" ${server_args:-}

# vim: ft=sh: et: sw=4: sts=4
