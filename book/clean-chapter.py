#!/usr/bin/env python3
"""Clean pandoc Typst chapters: trim rules, normalise session metadata."""
import re
import sys
from pathlib import Path


def parse_meta_text(text: str) -> dict[str, str]:
    out: dict[str, str] = {}
    text = text.replace("\\", " ").strip()
    parts = re.split(r"#strong\[(Date|Topic|Teacher):\]\s*", text)
    if len(parts) > 1:
        i = 1
        while i + 1 < len(parts):
            key = parts[i].strip().lower()
            val = parts[i + 1].strip()
            val = re.split(r"#strong\[", val)[0].strip()
            out[key] = val
            i += 2
    return out


def format_meta(meta: dict[str, str]) -> list[str]:
    if not meta:
        return []
    teacher = meta.get("teacher", "")
    if "Omar" in teacher:
        teacher = "Mufti Umar Aejaz"
    lines = ["#class-meta("]
    if "date" in meta:
        lines.append(f'  date: [{meta["date"]}],')
    if "topic" in meta:
        lines.append(f'  topic: [{meta["topic"]}],')
    if teacher:
        lines.append(f"  teacher: [{teacher}],")
    lines.extend([")", ""])
    return lines


def is_meta_line(s: str) -> bool:
    if not s:
        return False
    if s.startswith("#strong[Date") or s.startswith("#strong[Topic") or s.startswith("#strong[Teacher"):
        return True
    if s.startswith("<") or s.startswith("=") or s.startswith("=="):
        return False
    # Continuation of wrapped pandoc line (no block marker)
    return not s.startswith("#") or s.startswith("#strong")


def sanitize_typst_labels(text: str) -> str:
    """Typst labels must be ASCII letters, numbers, and hyphens only."""

    def fix_label(match: re.Match[str]) -> str:
        raw = match.group(1)
        safe = raw.lower()
        safe = safe.replace("ﷺ", "").replace("ṣ", "s").replace("ḥ", "h")
        safe = safe.replace("ā", "a").replace("ī", "i").replace("ū", "u")
        safe = safe.replace("ʿ", "").replace("’", "").replace("'", "")
        safe = re.sub(r"[^a-z0-9-]+", "-", safe)
        safe = re.sub(r"-+", "-", safe).strip("-")
        if not safe:
            safe = "section"
        return f"<{safe}>"

    return re.sub(r"<([^>\n]+)>", fix_label, text)


def clean(text: str) -> str:
    lines = text.splitlines()
    if not lines:
        return text

    imports = ['#import "../lib.typ": horizontalrule, class-meta']

    start = 0
    while start < len(lines) and lines[start].strip().startswith("#import"):
        start += 1

    body = lines[start:]

    while body and body[0].strip() == "":
        body.pop(0)

    header: list[str] = []
    if body and body[0].strip().startswith("="):
        header.append(body.pop(0))
    if body and body[0].strip().startswith("<"):
        header.append(body.pop(0))

    meta_chunks: list[str] = []
    while body and is_meta_line(body[0].strip()):
        meta_chunks.append(body.pop(0).strip())
    meta = parse_meta_text(" ".join(meta_chunks))

    i = 0
    while i < len(body):
        if body[i].strip() == "#horizontalrule":
            body.pop(i)
            while i < len(body) and body[i].strip() == "":
                body.pop(i)
            break
        if body[i].strip().startswith("=="):
            break
        i += 1

    while body and body[-1].strip() == "":
        body.pop()
    if body and body[-1].strip() == "#horizontalrule":
        body.pop()
    while body and body[-1].strip() == "":
        body.pop()

    out_lines = imports + [""] + header + format_meta(meta) + body
    result = "\n".join(out_lines) + "\n"
    return sanitize_typst_labels(result)


if __name__ == "__main__":
    path = Path(sys.argv[1])
    path.write_text(clean(path.read_text(encoding="utf-8")), encoding="utf-8")
