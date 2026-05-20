#!/usr/bin/env bash
# Build Masail e Hajj PDF from class markdown notes
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BOOK="$(cd "$(dirname "$0")" && pwd)"
OUT="$BOOK/output"
mkdir -p "$OUT"

echo "→ Converting markdown chapters to Typst…"
for n in 1 2 3 4 5; do
  case $n in
    1) f="May 11 2026 - Masail e Hajj - Class 1 - Conditions That Make Hajj Obligatory.md" ;;
    2) f="May 12 2026 - Masail e Hajj - Class 2 - Istitaat and the Blind Person.md" ;;
    3) f="May 13 2026 - Masail e Hajj - Class 3 - Zad and Rahila.md" ;;
    4) f="May 18 2026 - Masail e Hajj - Class 4 - Amn al-Tariq and Women's Conditions.md" ;;
    5) f="May 19 2026 - Masail e Hajj - Class 5 - Iddah Travel Restrictions and Hajj Badal.md" ;;
  esac
  out="$BOOK/chapters/class-$(printf '%02d' "$n").typ"
  pandoc "$ROOT/$f" -o "$out" -t typst
  tmp="$(mktemp)"
  {
    echo '#import "../lib.typ": horizontalrule'
    cat "$out"
  } > "$tmp"
  mv "$tmp" "$out"
  python3 "$BOOK/clean-chapter.py" "$out"
done

echo "→ Compiling PDF with Typst…"
typst compile "$BOOK/main.typ" "$OUT/Masail-e-Hajj.pdf" "$@"

echo "✓ Built: $OUT/Masail-e-Hajj.pdf"
