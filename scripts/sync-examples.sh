#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage:
  scripts/sync-examples.sh [--check]

Copies full-deck authoring exemplars from templates/full-decks/<name>/index.html
to examples/<name>/index.html and rewrites repository-relative asset paths.

Options:
  --check   Do not write files; fail if examples are missing or out of sync.
EOF
}

check_only=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check)
      check_only=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unexpected argument: $1" >&2
      usage
      exit 2
      ;;
  esac
  shift || true
done

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/.." && pwd)"

python3 - "$repo_dir" "$check_only" <<'PY'
import difflib
import sys
from pathlib import Path

repo = Path(sys.argv[1])
check_only = sys.argv[2] == "1"
templates_dir = repo / "templates" / "full-decks"
examples_dir = repo / "examples"

failures = []
synced = []

def public_demo_html(source):
    text = source.read_text(encoding="utf-8")
    return text.replace("../../../assets/", "../../assets/")

for deck_dir in sorted(path for path in templates_dir.iterdir() if path.is_dir()):
    source = deck_dir / "index.html"
    if not source.exists():
        continue
    target_dir = examples_dir / deck_dir.name
    target = target_dir / "index.html"
    expected = public_demo_html(source)
    if check_only:
        if not target.exists():
            failures.append(f"Missing generated example: {target.relative_to(repo)}")
            continue
        actual = target.read_text(encoding="utf-8")
        if actual != expected:
            diff = "\n".join(difflib.unified_diff(
                actual.splitlines(),
                expected.splitlines(),
                fromfile=str(target.relative_to(repo)),
                tofile=str(source.relative_to(repo)),
                lineterm="",
            ))
            failures.append(f"Out-of-sync generated example: {target.relative_to(repo)}\n{diff}")
        continue
    target_dir.mkdir(parents=True, exist_ok=True)
    target.write_text(expected, encoding="utf-8")
    synced.append(str(target.relative_to(repo)))

template_names = {path.name for path in templates_dir.iterdir() if path.is_dir() and (path / "index.html").exists()}
for example_dir in sorted(path for path in examples_dir.iterdir() if path.is_dir()):
    if (example_dir / "index.html").exists() and example_dir.name not in template_names:
        failures.append(f"Example has no matching full-deck source: {example_dir.relative_to(repo)}")

if failures:
    print("Full-deck example sync check failed:", file=sys.stderr)
    for failure in failures:
        print(failure, file=sys.stderr)
    sys.exit(1)

if check_only:
    print("Full-deck examples are in sync.")
else:
    for path in synced:
        print(f"Synced: {path}")
PY
