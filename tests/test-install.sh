#!/bin/sh
# All writes are isolated below a freshly-created temporary directory.
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

# Exercise a source repository path containing spaces, independent of current cwd.
source_dir="$tmp/source repository with spaces"
mkdir -p "$source_dir/skills/iphone-home-organizer"
cp "$repo/install.sh" "$source_dir/install.sh"
cp "$repo/skills/iphone-home-organizer/SKILL.md" "$source_dir/skills/iphone-home-organizer/SKILL.md"
source_file="$source_dir/skills/iphone-home-organizer/SKILL.md"

home="$tmp/default home with spaces"
mkdir "$home"
(cd "$tmp" && unset CODEX_HOME && HOME="$home" sh "$source_dir/install.sh")
target="$home/.agents/skills/iphone-home-organizer"
cmp "$source_file" "$target/SKILL.md"
[ "$(find "$target" -type f | wc -l | tr -d ' ')" -eq 1 ] || fail 'unexpected installed files'
pass 'default HOME and source path with spaces; only SKILL.md copied'

printf '%s\n' 'keep my local edits' > "$target/SKILL.md"
printf '%s\n' 'keep sibling file' > "$target/KEEP"
expect_failure env HOME="$home" CODEX_HOME="$home/.agents" sh "$source_dir/install.sh"
[ "$(cat "$target/SKILL.md")" = 'keep my local edits' ] || fail 'existing skill overwritten'
[ "$(cat "$target/KEEP")" = 'keep sibling file' ] || fail 'existing sibling changed'
pass 'existing installation refused without clobbering files'

custom="$tmp/custom Codex base"
env HOME="$home" CODEX_HOME="$custom" sh "$source_dir/install.sh"
cmp "$source_file" "$custom/skills/iphone-home-organizer/SKILL.md"
pass 'custom absolute CODEX_HOME with spaces'

empty_home="$tmp/empty variable home"
mkdir "$empty_home"
env HOME="$empty_home" CODEX_HOME='' sh "$source_dir/install.sh"
cmp "$source_file" "$empty_home/.agents/skills/iphone-home-organizer/SKILL.md"
pass 'empty CODEX_HOME falls back to HOME'

file_base="$tmp/file destination"
mkdir -p "$file_base/skills"
printf '%s\n' 'regular file stays' > "$file_base/skills/iphone-home-organizer"
expect_failure env CODEX_HOME="$file_base" sh "$source_dir/install.sh"
[ "$(cat "$file_base/skills/iphone-home-organizer")" = 'regular file stays' ] || fail 'destination file changed'
pass 'existing regular-file destination refused'

link_base="$tmp/link destination"
mkdir -p "$link_base/skills" "$tmp/link outside"
printf '%s\n' 'outside stays' > "$tmp/link outside/KEEP"
ln -s "$tmp/link outside" "$link_base/skills/iphone-home-organizer"
expect_failure env CODEX_HOME="$link_base" sh "$source_dir/install.sh"
[ ! -e "$tmp/link outside/SKILL.md" ] || fail 'followed destination symlink'
[ "$(cat "$tmp/link outside/KEEP")" = 'outside stays' ] || fail 'symlink target changed'
pass 'existing symlink destination refused without following it'

broken_base="$tmp/broken link destination"
mkdir -p "$broken_base/skills"
ln -s "$tmp/nonexistent" "$broken_base/skills/iphone-home-organizer"
expect_failure env CODEX_HOME="$broken_base" sh "$source_dir/install.sh"
[ -L "$broken_base/skills/iphone-home-organizer" ] || fail 'broken symlink changed'
[ ! -e "$tmp/nonexistent" ] || fail 'broken symlink target created'
pass 'broken destination symlink refused'

expect_failure env CODEX_HOME='relative destination' sh "$source_dir/install.sh"
pass 'relative destination rejected'

missing_repo="$tmp/missing source"
mkdir "$missing_repo"
cp "$source_dir/install.sh" "$missing_repo/install.sh"
expect_failure env CODEX_HOME="$tmp/never created" sh "$missing_repo/install.sh"
[ ! -e "$tmp/never created" ] || fail 'destination created without source'
pass 'missing source rejected before any destination write'

expect_failure env CODEX_HOME="$tmp/no force" sh "$source_dir/install.sh" --force
[ ! -e "$tmp/no force" ] || fail 'unknown option wrote destination'
pass 'overwrite flag unavailable; unknown arguments rejected'

env CODEX_HOME="$tmp/help only" sh "$source_dir/install.sh" --help > "$tmp/help.log"
[ ! -e "$tmp/help only" ] || fail 'help wrote destination'
pass 'help does not install'

printf '\nAll %s installer tests passed. No real HOME was used.\n' "$passes"
