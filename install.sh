#!/bin/sh
# Copy only this repository's Agent Skills instructions. No network/device actions.
set -eu

usage() {
    printf '%s\n' \
        'Usage: sh install.sh [--agent shared|codex|claude|cursor|gemini|opencode]' \
        'Default: shared -> $HOME/.agents/skills/iphone-home-organizer/' \
        'codex: $CODEX_HOME/skills if set, otherwise $HOME/.agents/skills' \
        'claude: $HOME/.claude/skills' \
        'cursor: $HOME/.cursor/skills' \
        'gemini: $HOME/.gemini/skills' \
        'opencode: $HOME/.config/opencode/skills' \
        'Copies only SKILL.md. Refuses any existing destination; no force option.' \
        'Does not install or enable Computer Use, permissions, or device access.'
}

agent=shared
case "$#" in
    0) ;;
    1)
        if [ "$1" = '--help' ]; then usage; exit 0; fi
        usage >&2; exit 2 ;;
    2)
        if [ "$1" != '--agent' ]; then usage >&2; exit 2; fi
        agent=$2 ;;
    *) usage >&2; exit 2 ;;
esac
case "$agent" in
    shared|codex|claude|cursor|gemini|opencode) ;;
    *) printf '%s\n' "Error: Unknown agent target: $agent" >&2; usage >&2; exit 2 ;;
esac

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
source_file="$script_dir/skills/iphone-home-organizer/SKILL.md"
if [ ! -f "$source_file" ] || [ -L "$source_file" ]; then
    printf '%s\n' "Error: Missing regular skill source: $source_file" >&2
    exit 1
fi

if [ "$agent" = codex ] && [ -n "${CODEX_HOME:-}" ]; then
    skills_root="$CODEX_HOME/skills"
else
    if [ -z "${HOME:-}" ]; then
        printf '%s\n' 'Error: HOME must be set to an absolute directory path.' >&2
        exit 1
    fi
    case "$agent" in
        shared|codex) skills_root="$HOME/.agents/skills" ;;
        claude) skills_root="$HOME/.claude/skills" ;;
        cursor) skills_root="$HOME/.cursor/skills" ;;
        gemini) skills_root="$HOME/.gemini/skills" ;;
        opencode) skills_root="$HOME/.config/opencode/skills" ;;
    esac
fi
case "$skills_root" in
    /*) ;;
    *) printf '%s\n' 'Error: Installation base must be an absolute path.' >&2; exit 1 ;;
esac

target="$skills_root/iphone-home-organizer"
if [ -e "$target" ] || [ -L "$target" ]; then
    printf '%s\n' "Refusing to overwrite existing destination: $target" >&2
    printf '%s\n' 'Review the existing skill and move it yourself before installing.' >&2
    exit 1
fi

umask 077
mkdir -p "$skills_root"
# Atomic no-clobber gate, including if another install wins a race.
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

printf '%s\n' "Installed skill instructions for $agent: $target/SKILL.md" \
    'No device changes or Computer Use setup were performed.' \
    'Use the supported skill discovery/invocation for your host, or ask it to read SKILL.md.' \
    'Applying a layout still requires authorized Computer Use and your explicit approval.'
