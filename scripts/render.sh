#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage:
  scripts/render.sh <deck.html-or-url> [out-dir] [--pdf] [--png] [--all]

Defaults:
  Creates a PDF in <deck-dir>/dist. The HTML file itself remains the source deck.

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

while [[ $# -gt 0 ]]; do
  case "$1" in
    --pdf)
      render_pdf=1
      ;;
    --png)
      render_png=1
      ;;
    --all)
      render_pdf=1
      render_png=1
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

if [[ "$render_pdf" -eq 0 && "$render_png" -eq 0 ]]; then
  render_pdf=1
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

if [[ "$target" =~ ^https?:// || "$target" =~ ^file:// ]]; then
  input_url="$target"
  input_name="deck"
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
  if [[ "$url" == *"?"* ]]; then
    printf '%s&%s' "$url" "$query"
  else
    printf '%s?%s' "$url" "$query"
  fi
}

count_slides() {
  if [[ "$target" =~ ^https?:// || "$target" =~ ^file:// ]]; then
    echo "${SLIDE_COUNT:-1}"
  else
    local count
    count="$(rg -o '<section[^>]+class="[^"]*slide' "$input_path" | wc -l | tr -d ' ')"
    if [[ -z "$count" || "$count" == "0" ]]; then
      echo 1
    else
      echo "$count"
    fi
  fi
}

chrome_common=(
  --headless=new
  --disable-gpu
  --no-first-run
  --no-default-browser-check
  --allow-file-access-from-files
  --virtual-time-budget=2500
)

if [[ "$render_pdf" -eq 1 ]]; then
  pdf_file="${out_dir}/${input_name}.pdf"
  pdf_url="$(append_query "$input_url" "print=1")"
  "$chrome" "${chrome_common[@]}" --print-to-pdf="$pdf_file" --print-to-pdf-no-header "$pdf_url" >/dev/null 2>&1
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
