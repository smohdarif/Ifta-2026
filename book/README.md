# Masā'il al-Ḥajj — Typst Book

Islamic-themed PDF compiled from class markdown notes.

## Build

```bash
./book/build.sh
```

Output: **`book/output/Masail-e-Hajj.pdf`**

Requires [Typst](https://typst.app/) and [Pandoc](https://pandoc.org/).

## Structure

| File | Purpose |
|------|---------|
| `main.typ` | Master document |
| `lib.typ` | Theme, colours, typography, front pages |
| `frontmatter.typ` | Introduction, TOC, session list |
| `chapters/class-*.typ` | Generated from `../*.md` (do not edit by hand—re-run build) |
| `build.sh` | Converts markdown → Typst → PDF |

## Theme

- Warm parchment background, emerald headings, gold ornaments
- Generous line spacing and paragraph spacing for comfortable reading
- Arabic blocks with right alignment and side border
- Quote and table styling consistent across sessions

## Credits

- **School:** Darul Uloom Wal Funoon
- **Teacher:** Mufti Umar Aejaz
- **Compiled by:** Arif Shaikh
- **Reference:** *Badā'iʿ al-Ṣanā'iʿ* (vol. 3) — `03.pdf` in repo root

Add new sessions by creating a dated markdown file in the repo root, then extend `build.sh` with the next class number.
