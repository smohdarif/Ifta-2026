#!/usr/bin/env bash
# Build Masail e Hajj PDF from class markdown notes
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BOOK="$(cd "$(dirname "$0")" && pwd)"
OUT="$BOOK/output"
mkdir -p "$OUT"

# Markdown sources → class-XX.typ (order = book order)
MD_CHAPTERS=(
  "May 11 2026 - Masail e Hajj - Class 1 - Conditions That Make Hajj Obligatory.md"
  "May 12 2026 - Masail e Hajj - Class 2 - Istitaat and the Blind Person.md"
  "May 13 2026 - Masail e Hajj - Class 3 - Zad and Rahila.md"
  "May 18 2026 - Masail e Hajj - Class 4 - Amn al-Tariq and Women's Conditions.md"
  "May 19 2026 - Masail e Hajj - Class 5 - Iddah Travel Restrictions and Hajj Badal.md"
  "May 21 2026 - Masail e Hajj - Class 6 - Wuquf Arafah Obligation Place and Timing.md"
  "May 22 2026 - Masail e Hajj - Class 7 - Wuquf Arafah Duration Departure and Udhiyah.md"
  "May 23 2026 - Masail e Hajj - Class 8 - Ahkam e Eid ul Azha and Qurbani.md"
  "June 1 2026 - Masail e Hajj - Class 9 - Tawaf al-Ziyarah Obligation and Rukn.md"
  "June 2 2026 - Masail e Hajj - Class 10 - Taharat and Wajibat of Tawaf.md"
  "June 3 2026 - Masail e Hajj - Class 11 - Tawaf al-Ziyarah Sunan Timing and Rulings.md"
  "June 8 2026 - Masail e Hajj - Class 12 - Sai Status Wajibat and Penalty Framework.md"
  "June 9 2026 - Masail e Hajj - Class 13 - Sai Conditions Timing and Missed Rulings.md"
  "June 10 2026 - Masail e Hajj - Class 14 - Wuquf Muzdalifah and Rami al-Jimar Introduction.md"
  "June 12 2026 - Masail e Hajj - Class 15 - Rami Missed Rulings Tadakhul and Qada.md"
  "June 16 2026 - Masail e Hajj - Class 16 - Halq Completion and Tawaf al-Sadr Obligation.md"
  "June 17 2026 - Masail e Hajj - Class 17 - Tawaf al-Sadr Rulings and Sunan of Ihram.md"
  "June 22 2026 - Masail e Hajj - Class 18 - Sunan of Tawaf Istilam Ramal and Two Rakats.md"
  "June 24 2026 - Masail e Hajj - Class 19 - Tawaf al-Qudum for the Three Hajj Types.md"
)

echo "→ Converting markdown chapters to Typst…"
n=0
for f in "${MD_CHAPTERS[@]}"; do
  n=$((n + 1))
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
