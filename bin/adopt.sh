#!/usr/bin/env bash
# adopt.sh — copy the kit into a repo, once.
#
# Usage:
#   bin/adopt.sh [--dry-run] [TARGET_DIR]
#
# TARGET_DIR defaults to the current directory. Run it from the repo you
# are adopting, or pass the repo path explicitly.
#
# What it does:
#   - copies kit/.claude/, kit/docs/, and CLAUDE.md.template -> CLAUDE.md
#   - symlinks AGENTS.md -> CLAUDE.md (skipped if AGENTS.md exists)
#   - never overwrites: existing files are reported and left alone
#   - ends with the list of ALL_CAPS placeholders still to fill in
#
# What it deliberately does NOT do:
#   - touch git (no init, add, or commit — review and commit yourself)
#   - merge into existing files (a repo with its own CLAUDE.md keeps it)
#   - install anything (there is no plugin; the workflow is instructions)

set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../kit" && pwd)"
DRY_RUN=0

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) sed -n '2,19p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*) echo "unknown option: $1" >&2; exit 2 ;;
    *) TARGET="$1"; shift ;;
  esac
done

TARGET="$(cd "${TARGET:-.}" && pwd)"

if [ "$TARGET" = "$(cd "$KIT_DIR/.." && pwd)" ]; then
  echo "refusing to adopt the playbook repo into itself" >&2
  exit 2
fi

copied=0 skipped=0

# copy_file SRC DEST_RELATIVE
copy_file() {
  local src="$1" rel="$2" dest="$TARGET/$2"
  if [ -e "$dest" ]; then
    echo "  skip   $rel (exists)"
    skipped=$((skipped + 1))
    return
  fi
  echo "  copy   $rel"
  if [ "$DRY_RUN" -eq 0 ]; then
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
  fi
  copied=$((copied + 1))
}

echo "adopting kit into: $TARGET"
[ "$DRY_RUN" -eq 1 ] && echo "(dry run — nothing will be written)"

# 1. Everything under kit/.claude/ and kit/docs/, path-preserved.
while IFS= read -r src; do
  copy_file "$src" "${src#"$KIT_DIR/"}"
done < <(find "$KIT_DIR/.claude" "$KIT_DIR/docs" -type f | sort)

# 2. CLAUDE.md.template becomes CLAUDE.md at the repo root.
copy_file "$KIT_DIR/CLAUDE.md.template" "CLAUDE.md"

# 3. AGENTS.md symlink for tools that read that name.
if [ -e "$TARGET/AGENTS.md" ] || [ -L "$TARGET/AGENTS.md" ]; then
  echo "  skip   AGENTS.md (exists)"
  skipped=$((skipped + 1))
else
  echo "  link   AGENTS.md -> CLAUDE.md"
  [ "$DRY_RUN" -eq 0 ] && ln -s CLAUDE.md "$TARGET/AGENTS.md"
  copied=$((copied + 1))
fi

echo
echo "done: $copied copied, $skipped skipped."

# 4. Report remaining placeholders so the fill-in step can't be forgotten.
if [ "$DRY_RUN" -eq 0 ]; then
  echo
  echo "placeholders still to fill in:"
  if ! (cd "$TARGET" && grep -rn --include='*.md' -o '[A-Z_]\{2,\}\(_[A-Z_]\{2,\}\)*' \
      CLAUDE.md .claude/agents/verify-app.md 2>/dev/null) \
      | grep -E '_(NAME|COMMAND|DESCRIPTION|VERSION|LIBS|FILE|DIRS|BRANCH|RISKY)|^.*:(PROJECT|ANYTHING)_' \
      | sort -u | sed 's/^/  /'; then
    echo "  (none found)"
  fi
  echo
  echo "next steps:"
  echo "  1. Fill in CLAUDE.md (keep it <= 60 lines) and .claude/agents/verify-app.md"
  echo "  2. Adjust the allowlist in .claude/settings.json to your build/test/lint commands"
  echo "  3. Review and commit — it's team config"
fi
