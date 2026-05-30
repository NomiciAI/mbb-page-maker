#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage:
  scripts/render.sh <deck.html-or-url> [out-dir] [--pdf] [--png] [--package] [--all]

Defaults:
  Creates a self-contained share package, PDF, and PNG slides in <deck-dir>/dist.

Examples:
  scripts/render.sh examples/demo-deck/index.html
  scripts/render.sh examples/demo-deck/index.html out/demo --all
  scripts/render.sh templates/showcase/full-deck-operating-case-mono.html --png
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 2
fi

target="$1"
shift || true

out_dir=""
render_pdf=0
render_png=0
render_package=0
package_index=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pdf)
      render_pdf=1
      ;;
    --png)
      render_png=1
      ;;
    --package)
      render_package=1
      ;;
    --all)
      render_pdf=1
      render_png=1
      render_package=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ -z "$out_dir" ]]; then
        out_dir="$1"
      else
        echo "Unexpected argument: $1" >&2
        usage
        exit 2
      fi
      ;;
  esac
  shift || true
done

if [[ "$render_pdf" -eq 0 && "$render_png" -eq 0 && "$render_package" -eq 0 ]]; then
  render_pdf=1
  render_png=1
  render_package=1
fi

if [[ -n "${CHROME_BIN:-}" ]]; then
  chrome="$CHROME_BIN"
elif [[ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]]; then
  chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
elif command -v google-chrome >/dev/null 2>&1; then
  chrome="$(command -v google-chrome)"
elif command -v chromium >/dev/null 2>&1; then
  chrome="$(command -v chromium)"
elif command -v chromium-browser >/dev/null 2>&1; then
  chrome="$(command -v chromium-browser)"
else
  echo "Chrome/Chromium not found. Set CHROME_BIN=/path/to/chrome and retry." >&2
  exit 2
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_root="$(cd "${script_dir}/.." && pwd)"

if [[ "$target" =~ ^https?:// || "$target" =~ ^file:// ]]; then
  input_url="$target"
  input_name="deck"
  input_path=""
  input_dir="$(pwd)"
  default_out="dist"
else
  input_path="$(cd "$(dirname "$target")" && pwd)/$(basename "$target")"
  if [[ ! -f "$input_path" ]]; then
    echo "Deck not found: $target" >&2
    exit 2
  fi
  input_dir="$(dirname "$input_path")"
  input_name="$(basename "$input_path" .html)"
  input_url="file://${input_path}"
  default_out="${input_dir}/dist"
fi

if [[ -z "$out_dir" ]]; then
  out_dir="$default_out"
fi

mkdir -p "$out_dir"

append_query() {
  local url="$1"
  local query="$2"
  local base="$url"
  local hash=""
  if [[ "$base" == *"#"* ]]; then
    hash="#${base#*#}"
    base="${base%%#*}"
  fi
  if [[ "$base" == *"?"* ]]; then
    printf '%s&%s%s' "$base" "$query" "$hash"
  else
    printf '%s?%s%s' "$base" "$query" "$hash"
  fi
}

count_slides() {
  if [[ -n "$input_path" ]]; then
    python3 - "$input_path" <<'PY'
from html.parser import HTMLParser
from pathlib import Path
import sys

class SlideCounter(HTMLParser):
    def __init__(self):
        super().__init__()
        self.count = 0

    def handle_starttag(self, tag, attrs):
        if tag.lower() != "section":
            return
        values = dict(attrs)
        classes = values.get("class", "")
        if "slide" in classes.split():
            self.count += 1

parser = SlideCounter()
parser.feed(Path(sys.argv[1]).read_text(encoding="utf-8"))
print(parser.count or 1)
PY
  else
    echo "${SLIDE_COUNT:-1}"
  fi
}

relative_path() {
  python3 - "$1" "$2" <<'PY'
import os
import sys
print(os.path.relpath(sys.argv[1], start=sys.argv[2]))
PY
}

rewrite_asset_paths() {
  local html_file="$1"
  local from_dir="$2"
  local to_dir="$3"
  local skill_root_path="$4"
  python3 - "$html_file" "$from_dir" "$to_dir" "$skill_root_path" <<'PY'
import os
import re
import sys
from pathlib import Path

html_path = Path(sys.argv[1])
html_dir = html_path.parent.resolve()
from_dir = Path(sys.argv[2]).resolve()
to_dir = Path(sys.argv[3]).resolve()
skill_root = Path(sys.argv[4]).resolve()
text = html_path.read_text(encoding="utf-8")

def repl(match):
    attr, quote, value = match.groups()
    if value.startswith(("http://", "https://", "data:", "#", "mailto:", "tel:")):
        return match.group(0)
    if not value:
        return match.group(0)
    raw = value.split("?", 1)[0].split("#", 1)[0]
    suffix = value[len(raw):]
    candidates = []
    if raw.startswith("/"):
        candidates.append(Path(raw))
    else:
        candidates.append((from_dir / raw).resolve())
    if "/.agents/skills/mbb-page-maker/" in raw:
        tail = raw.split("/.agents/skills/mbb-page-maker/", 1)[1]
        candidates.insert(0, skill_root / tail)
    if "mbb-page-maker/" in raw:
        tail = raw.split("mbb-page-maker/", 1)[1]
        candidates.append(skill_root / tail)
    source = next((path for path in candidates if path.exists()), None)
    if not source:
        return match.group(0)
    if skill_root in source.parents or source == skill_root:
        dest = to_dir / "assets" / source.relative_to(skill_root / "assets") if (skill_root / "assets") in source.parents else to_dir / source.name
    else:
        try:
            rel = source.relative_to(from_dir)
            dest = to_dir / rel
        except ValueError:
            dest = to_dir / "assets" / "media" / source.name
    dest.parent.mkdir(parents=True, exist_ok=True)
    if source.is_file():
        if not dest.exists():
            dest.write_bytes(source.read_bytes())
    new_value = os.path.relpath(dest.resolve(), start=html_dir).replace(os.sep, "/") + suffix
    return f"{attr}={quote}{new_value}{quote}"

pattern = re.compile(r'\b(src|href)=(["\'])([^"\']+)\2')
html_path.write_text(pattern.sub(repl, text), encoding="utf-8")
PY
}

inline_package_assets() {
  local html_file="$1"
  python3 - "$html_file" <<'PY'
import base64
import mimetypes
import re
import sys
from pathlib import Path

html_path = Path(sys.argv[1])
html_dir = html_path.parent.resolve()
text = html_path.read_text(encoding="utf-8")

def is_external(value):
    return value.startswith(("http://", "https://", "data:", "#", "mailto:", "tel:"))

def local_path(value, base_dir):
    if not value or is_external(value):
        return None, ""
    raw = value.split("?", 1)[0].split("#", 1)[0]
    suffix = value[len(raw):]
    path = Path(raw) if Path(raw).is_absolute() else (base_dir / raw)
    path = path.resolve()
    if not path.is_file():
        return None, suffix
    try:
        path.relative_to(html_dir)
    except ValueError:
        return None, suffix
    return path, suffix

def data_uri(path):
    mime = mimetypes.guess_type(path.name)[0] or "application/octet-stream"
    payload = base64.b64encode(path.read_bytes()).decode("ascii")
    return f"data:{mime};base64,{payload}"

def inline_css_urls(css_text, css_path):
    css_dir = css_path.parent.resolve()
    pattern = re.compile(r"url\((['\"]?)([^)'\"\s]+)\1\)")

    def repl(match):
        quote, value = match.groups()
        if is_external(value):
            return match.group(0)
        path, _suffix = local_path(value, css_dir)
        if not path:
            return match.group(0)
        return f"url({quote}{data_uri(path)}{quote})"

    return pattern.sub(repl, css_text)

def read_css(path):
    css = path.read_text(encoding="utf-8")
    return inline_css_urls(css, path).replace("</style", "<\\/style")

def read_js(path):
    return path.read_text(encoding="utf-8").replace("</script", "<\\/script")

def get_attr(tag, name):
    match = re.search(rf"\b{name}\s*=\s*(['\"])(.*?)\1", tag, flags=re.I | re.S)
    return match.group(2) if match else None

def has_stylesheet_rel(tag):
    rel = get_attr(tag, "rel")
    return bool(rel and "stylesheet" in rel.lower().split())

def replace_link(match):
    tag = match.group(0)
    href = get_attr(tag, "href")
    path, _suffix = local_path(href, html_dir)
    if not path or not has_stylesheet_rel(tag):
        return tag
    css = read_css(path)
    source = path.relative_to(html_dir).as_posix()
    return f'<style data-inlined-from="{source}">\n{css}\n</style>'

def replace_script(match):
    tag = match.group(0)
    src = get_attr(tag, "src")
    path, _suffix = local_path(src, html_dir)
    if not path:
        return tag
    js = read_js(path)
    source = path.relative_to(html_dir).as_posix()
    return f'<script data-inlined-from="{source}">\n{js}\n</script>'

def replace_media_tag(match):
    tag = match.group(0)
    src_match = re.search(r"\bsrc\s*=\s*(['\"])([^'\"]+)\1", tag, flags=re.I | re.S)
    if not src_match:
        return tag
    quote, value = src_match.groups()
    path, _suffix = local_path(value, html_dir)
    if not path:
        return tag
    replacement = f"src={quote}{data_uri(path)}{quote}"
    return tag[:src_match.start()] + replacement + tag[src_match.end():]

def replace_style_block(match):
    open_tag, css, close_tag = match.groups()
    return open_tag + inline_css_urls(css, html_dir).replace("</style", "<\\/style") + close_tag

text = re.sub(r"<link\b[^>]*>", replace_link, text, flags=re.I | re.S)
text = re.sub(r"<script\b[^>]*\bsrc\s*=\s*(['\"]).*?\1[^>]*>\s*</script>", replace_script, text, flags=re.I | re.S)
text = re.sub(r"<(?:img|source|video|audio|track|iframe|embed)\b[^>]*>", replace_media_tag, text, flags=re.I | re.S)
text = re.sub(r"(<style\b[^>]*>)(.*?)(</style>)", replace_style_block, text, flags=re.I | re.S)

html_path.write_text(text, encoding="utf-8")
PY
}

verify_package_index() {
  local html_file="$1"
  python3 - "$html_file" <<'PY'
import re
import sys
from html.parser import HTMLParser
from pathlib import Path

html_path = Path(sys.argv[1])
text = html_path.read_text(encoding="utf-8")
failures = []

def resource_value_is_embedded(value):
    if not value:
        return True
    value = value.strip()
    return value.startswith(("data:", "#", "mailto:", "tel:"))

def check_srcset(value, label):
    for item in value.split(","):
        candidate = item.strip().split()
        if candidate and not resource_value_is_embedded(candidate[0]):
            failures.append(f"{label} uses non-embedded srcset resource: {candidate[0]}")

class ResourceChecker(HTMLParser):
    resource_tags = {"img", "source", "video", "audio", "track", "iframe", "embed", "object"}

    def handle_starttag(self, tag, attrs):
        tag = tag.lower()
        values = {name.lower(): value for name, value in attrs}
        if tag == "link":
            rel = (values.get("rel") or "").lower().split()
            if "stylesheet" in rel or "icon" in rel or "preload" in rel:
                href = values.get("href")
                if not resource_value_is_embedded(href):
                    failures.append(f"<link rel='{values.get('rel')}'> is not embedded: {href}")
        if tag == "script":
            src = values.get("src")
            if src:
                failures.append(f"<script> uses external src: {src}")
        if tag in self.resource_tags:
            attr = "data" if tag == "object" else "src"
            value = values.get(attr)
            if value and not resource_value_is_embedded(value):
                failures.append(f"<{tag}> uses non-embedded {attr}: {value}")
            if values.get("srcset"):
                check_srcset(values["srcset"], f"<{tag}>")
        if values.get("style"):
            for url in re.findall(r"url\((['\"]?)(.*?)\1\)", values["style"], flags=re.I):
                raw = url[1].strip()
                if raw and not resource_value_is_embedded(raw):
                    failures.append(f"inline style uses non-embedded url(): {raw}")

parser = ResourceChecker()
parser.feed(text)

for style in re.findall(r"<style\b[^>]*>(.*?)</style>", text, flags=re.I | re.S):
    if re.search(r"@import\b", style, flags=re.I):
        failures.append("<style> contains @import")
    for url in re.findall(r"url\((['\"]?)(.*?)\1\)", style, flags=re.I):
        raw = url[1].strip()
        if raw and not resource_value_is_embedded(raw):
            failures.append(f"<style> uses non-embedded url(): {raw}")

if failures:
    print("Package verification failed:", file=sys.stderr)
    for failure in failures[:20]:
        print(f"- {failure}", file=sys.stderr)
    if len(failures) > 20:
        print(f"- ... {len(failures) - 20} more", file=sys.stderr)
    sys.exit(1)
PY
}

package_deck() {
  if [[ -z "$input_path" ]]; then
    echo "Package output requires a local HTML file input." >&2
    exit 2
  fi
  local package_dir="${out_dir}/package"
  rm -rf "$package_dir"
  mkdir -p "$package_dir"
  cp "$input_path" "${package_dir}/index.html"
  mkdir -p "${package_dir}/assets"
  cp -R "${skill_root}/assets/css" "${package_dir}/assets/"
  cp -R "${skill_root}/assets/js" "${package_dir}/assets/"
  cp -R "${skill_root}/assets/themes" "${package_dir}/assets/"
  if [[ -d "${skill_root}/assets/media" ]]; then
    cp -R "${skill_root}/assets/media" "${package_dir}/assets/"
  fi
  if [[ -f "${package_dir}/assets/css/fonts.css" ]]; then
    python3 - "${package_dir}/assets/css/fonts.css" <<'PY'
from pathlib import Path
import sys
path = Path(sys.argv[1])
lines = path.read_text(encoding="utf-8").splitlines()
path.write_text("\n".join(line for line in lines if not line.lstrip().startswith("@import")) + "\n", encoding="utf-8")
PY
  fi
  rewrite_asset_paths "${package_dir}/index.html" "$input_dir" "$package_dir" "$skill_root"
  inline_package_assets "${package_dir}/index.html"
  verify_package_index "${package_dir}/index.html"
  package_index="${package_dir}/index.html"
  echo "Package: ${package_dir}/index.html"
}

chrome_common=(
  --headless=new
  --disable-gpu
  --no-first-run
  --no-default-browser-check
  --allow-file-access-from-files
  --virtual-time-budget=2500
)

if [[ "$render_package" -eq 1 ]]; then
  package_deck
  input_url="file://${package_index}"
fi

if [[ "$render_pdf" -eq 1 ]]; then
  pdf_file="${out_dir}/${input_name}.pdf"
  pdf_url="$(append_query "$input_url" "print=1")"
  "$chrome" \
    "${chrome_common[@]}" \
    --run-all-compositor-stages-before-draw \
    --disable-dev-shm-usage \
    --print-to-pdf="$pdf_file" \
    --print-to-pdf-no-header \
    "$pdf_url" >/dev/null 2>&1
  echo "PDF: $pdf_file"
fi

if [[ "$render_png" -eq 1 ]]; then
  png_dir="${out_dir}/png"
  mkdir -p "$png_dir"
  slide_count="$(count_slides)"
  for ((i = 1; i <= slide_count; i += 1)); do
    png_file="${png_dir}/slide-$(printf '%02d' "$i").png"
    png_url="$(append_query "$input_url" "slide=${i}")"
    "$chrome" "${chrome_common[@]}" --window-size=1600,900 --screenshot="$png_file" "$png_url" >/dev/null 2>&1
    echo "PNG: $png_file"
  done
fi
