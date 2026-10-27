#!/bin/sh
# Isolated installer tests; never writes into a real agent configuration/home.
set -eu
repo=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/iphone-organizer-tests.XXXXXX")
trap 'rm -rf "$tmp"' EXIT HUP INT TERM
passes=0
pass() { passes=$((passes + 1)); printf 'ok %s - %s\n' "$passes" "$1"; }
fail() { printf 'FAIL: %s\n' "$1" >&2; exit 1; }
expect_failure() {
    if "$@" >"$tmp/expected-failure.log" 2>&1; then
        fail 'command unexpectedly succeeded'
    fi
}
sh -n "$repo/install.sh"
pass 'installer shell syntax'

source_dir="$tmp/source repository with spaces"
mkdir -p "$source_dir/skills/iphone-home-organizer"
cp "$repo/install.sh" "$source_dir/install.sh"
cp "$repo/skills/iphone-home-organizer/SKILL.md" "$source_dir/skills/iphone-home-organizer/SKILL.md"
source_file="$source_dir/skills/iphone-home-organizer/SKILL.md"
script="$source_dir/install.sh"

for agent in shared codex claude cursor gemini opencode; do
    home="$tmp/$agent home with spaces"
    mkdir "$home"
    case "$agent" in
        shared|codex) target="$home/.agents/skills/iphone-home-organizer" ;;
        claude) target="$home/.claude/skills/iphone-home-organizer" ;;
        cursor) target="$home/.cursor/skills/iphone-home-organizer" ;;
        gemini) target="$home/.gemini/skills/iphone-home-organizer" ;;
        opencode) target="$home/.config/opencode/skills/iphone-home-organizer" ;;
    esac
    (cd "$tmp" && HOME="$home" CODEX_HOME='' sh "$script" --agent "$agent")
    cmp "$source_file" "$target/SKILL.md"
    [ "$(find "$target" -type f | wc -l | tr -d ' ')" -eq 1 ] || fail 'unexpected installed files'
    pass "$agent: documented target and spaced paths; only SKILL.md copied"
    printf '%s\n' 'keep my local edits' > "$target/SKILL.md"
    printf '%s\n' 'keep sibling file' > "$target/KEEP"
    expect_failure env HOME="$home" CODEX_HOME='' sh "$script" --agent "$agent"
    [ "$(cat "$target/SKILL.md")" = 'keep my local edits' ] || fail 'existing skill overwritten'
    [ "$(cat "$target/KEEP")" = 'keep sibling file' ] || fail 'existing sibling changed'
    pass "$agent: existing installation refused without clobbering"
done

home="$tmp/default shared home"
mkdir "$home"
env HOME="$home" CODEX_HOME="$tmp/ignored Codex home" sh "$script"
cmp "$source_file" "$home/.agents/skills/iphone-home-organizer/SKILL.md"
[ ! -e "$tmp/ignored Codex home" ] || fail 'shared install used CODEX_HOME'
pass 'no arguments selects shared and ignores vendor configuration'

custom="$tmp/custom Codex base"
env HOME='' CODEX_HOME="$custom" sh "$script" --agent codex
cmp "$source_file" "$custom/skills/iphone-home-organizer/SKILL.md"
pass 'explicit codex supports absolute CODEX_HOME with spaces without HOME'

file_home="$tmp/file destination"
mkdir -p "$file_home/.agents/skills"
printf '%s\n' 'regular file stays' > "$file_home/.agents/skills/iphone-home-organizer"
expect_failure env HOME="$file_home" CODEX_HOME='' sh "$script"
[ "$(cat "$file_home/.agents/skills/iphone-home-organizer")" = 'regular file stays' ] || fail 'destination file changed'
pass 'regular-file destination refused'

link_home="$tmp/link destination"
mkdir -p "$link_home/.agents/skills" "$tmp/link outside"
printf '%s\n' 'outside stays' > "$tmp/link outside/KEEP"
ln -s "$tmp/link outside" "$link_home/.agents/skills/iphone-home-organizer"
expect_failure env HOME="$link_home" CODEX_HOME='' sh "$script"
[ ! -e "$tmp/link outside/SKILL.md" ] || fail 'followed destination symlink'
[ "$(cat "$tmp/link outside/KEEP")" = 'outside stays' ] || fail 'symlink target changed'
pass 'live symlink destination refused without following it'

broken_home="$tmp/broken link destination"
mkdir -p "$broken_home/.agents/skills"
ln -s "$tmp/nonexistent" "$broken_home/.agents/skills/iphone-home-organizer"
expect_failure env HOME="$broken_home" CODEX_HOME='' sh "$script"
[ -L "$broken_home/.agents/skills/iphone-home-organizer" ] || fail 'broken symlink changed'
[ ! -e "$tmp/nonexistent" ] || fail 'broken symlink target created'
pass 'broken symlink destination refused'

expect_failure env HOME='relative home' CODEX_HOME='' sh "$script"
pass 'relative HOME rejected'
expect_failure env HOME="$home" CODEX_HOME='relative codex' sh "$script" --agent codex
pass 'relative CODEX_HOME rejected for codex target'
expect_failure env HOME='' CODEX_HOME='' sh "$script" --agent claude
pass 'missing required HOME rejected'

missing_repo="$tmp/missing source"
mkdir "$missing_repo"
cp "$script" "$missing_repo/install.sh"
expect_failure env HOME="$tmp/never created" CODEX_HOME='' sh "$missing_repo/install.sh"
[ ! -e "$tmp/never created" ] || fail 'destination created without source'
pass 'missing source rejected before destination writes'

ln -s "$source_file" "$source_dir/skills/iphone-home-organizer/linked.md"
mv "$source_dir/skills/iphone-home-organizer/SKILL.md" "$source_dir/skills/iphone-home-organizer/original.md"
ln -s "$source_dir/skills/iphone-home-organizer/original.md" "$source_file"
expect_failure env HOME="$tmp/no linked source" CODEX_HOME='' sh "$script"
[ ! -e "$tmp/no linked source" ] || fail 'symlink source created destination'
rm "$source_file"
mv "$source_dir/skills/iphone-home-organizer/original.md" "$source_file"
pass 'symlink skill source refused'

for bad_agent in grokbot unknown ''; do
    expect_failure env HOME="$tmp/no bad agent" CODEX_HOME='' sh "$script" --agent "$bad_agent"
    [ ! -e "$tmp/no bad agent" ] || fail 'unknown agent wrote destination'
    pass "unsupported or empty agent rejected: ${bad_agent:-empty}"
done
expect_failure env HOME="$tmp/no force" CODEX_HOME='' sh "$script" --force
[ ! -e "$tmp/no force" ] || fail 'force option wrote destination'
pass 'force option unavailable'
expect_failure env HOME="$tmp/no missing argument" CODEX_HOME='' sh "$script" --agent
[ ! -e "$tmp/no missing argument" ] || fail 'missing argument wrote destination'
pass 'missing --agent value rejected'
expect_failure env HOME="$tmp/no duplicate" CODEX_HOME='' sh "$script" --agent codex --agent claude
[ ! -e "$tmp/no duplicate" ] || fail 'duplicate option wrote destination'
pass 'duplicate agent options rejected'
expect_failure env HOME="$tmp/no malformed" CODEX_HOME='' sh "$script" --unknown claude
[ ! -e "$tmp/no malformed" ] || fail 'unknown option wrote destination'
pass 'unknown two-part option rejected'

env HOME="$tmp/help only" CODEX_HOME='' sh "$script" --help > "$tmp/help.log"
[ ! -e "$tmp/help only" ] || fail 'help wrote destination'
pass 'help does not install'
printf '\nAll %s installer tests passed. No real HOME was used.\n' "$passes"
