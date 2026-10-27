#!/bin/sh
# Install only this repository's skill instructions. No network or device actions.
set -eu

usage() {
    printf '%s\n' \
        'Usage: sh install.sh' \
        'Copies only skills/iphone-home-organizer/SKILL.md to:' \
        '  $HOME/.agents/skills/iphone-home-organizer/ by default' \
        '  $CODEX_HOME/skills/iphone-home-organizer/ if CODEX_HOME is set' \
        'Refuses an existing destination. No overwrite/force option.' \
        'Does not install or enable Computer Use, permissions, or device access.'
}

if [ "$#" -ne 0 ]; then
    if [ "$#" -eq 1 ] && [ "$1" = '--help' ]; then
        usage
        exit 0
    fi
    usage >&2
    exit 2
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
source_file="$script_dir/skills/iphone-home-organizer/SKILL.md"
if [ ! -f "$source_file" ] || [ -L "$source_file" ]; then
    printf '%s\n' "Error: Missing regular skill source: $source_file" >&2
    exit 1
fi

if [ -n "${CODEX_HOME:-}" ]; then
    skills_root="$CODEX_HOME/skills"
elif [ -n "${HOME:-}" ]; then
    skills_root="$HOME/.agents/skills"
else
    printf '%s\n' 'Error: Set HOME or CODEX_HOME to an absolute directory path.' >&2
    exit 1
fi
case "$skills_root" in
    /*) ;;
    *) printf '%s\n' 'Error: CODEX_HOME/HOME must resolve to an absolute path.' >&2; exit 1 ;;
esac

target="$skills_root/iphone-home-organizer"
if [ -e "$target" ] || [ -L "$target" ]; then
    printf '%s\n' "Refusing to overwrite existing destination: $target" >&2
    printf '%s\n' 'Review the existing skill and choose a separate CODEX_HOME or move it yourself.' >&2
    exit 1
fi

umask 077
mkdir -p "$skills_root"
# mkdir is the no-clobber gate, including if another install wins a race.
if ! mkdir "$target"; then
    printf '%s\n' "Error: Could not create a new destination: $target" >&2
    exit 1
fi
if ! cp "$source_file" "$target/SKILL.md"; then
    printf '%s\n' "Error: Copy failed; inspect the incomplete destination: $target" >&2
    exit 1
fi
if ! cmp -s "$source_file" "$target/SKILL.md"; then
    printf '%s\n' "Error: Copy verification failed; inspect: $target" >&2
    exit 1
fi

printf '%s\n' "Installed skill instructions: $target/SKILL.md" \
    'No device changes or Computer Use setup were performed.' \
    'Open a Codex session that discovers this skill location and invoke $iphone-home-organizer.' \
    'Applying a layout still requires authorized Computer Use and your explicit approval.'
