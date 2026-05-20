#!/usr/bin/env python3
"""Clean pandoc Typst chapters: trim rules, normalise session metadata."""
import re
import sys
from pathlib import Path


def parse_meta_line(line: str) -> dict[str, str]:
    """Extract Date / Topic / Teacher from pandoc strong lines."""
    out: dict[str, str] = {}
    # Combined line: #strong[Date:] ... #strong[Topic:] ...
    parts = re.split(r"#strong\[(Date|Topic|Teacher):\]\s*", line)
    if len(parts) > 1:
        i = 1
        while i + 1 < len(parts):
            key = parts[i].strip().lower()
            val = parts[i + 1].strip().rstrip("\\").strip()
            # Stop at next label embedded in value
            for label in ("Date:", "Topic:", "Teacher:"):
                if label in val:
                    val = val.split("#strong")[0].strip()
            out[key] = val
            i += 2
        return out

    m = re.match(r"#strong\[(Date|Topic|Teacher):\]\s*(.+)", line.strip())
    if m:
        out[m.group(1).lower()] = m.group(2).strip().rstrip("\\").strip()
    return out


def format_meta(meta: dict[str, str]) -> list[str]:
    if not meta:
        return []
    args = []
    if "date" in meta:
        args.append(f'  date: [{meta["date"]}],')
    if "topic" in meta:
        args.append(f'  topic: [{meta["topic"]}],')
    if "teacher" in meta:
        args.append(f'  teacher: [{meta["teacher"]}],')
    return ["#class-meta("] + args + [")", ""]


def clean(text: str) -> str:
    lines = text.splitlines()
    if not lines:
        return text

    start = 0
    imports: list[str] = []
    while start < len(lines) and lines[start].strip().startswith("#import"):
        imp = lines[start].strip()
        if "class-meta" not in imp:
            imp = imp.rstrip("]")
            if imp.endswith(": horizontalrule"):
                imp = '#import "../lib.typ": horizontalrule, class-meta'
            elif "lib.typ" in imp and ":" in imp:
                imp = re.sub(
                    r'#import "\.\./lib\.typ": (.+)',
                    r'#import "../lib.typ": \1, class-meta',
                    imp,
                )
            else:
                imp = '#import "../lib.typ": horizontalrule, class-meta'
        imports.append(imp)
        start += 1

    if not imports:
        imports = ['#import "../lib.typ": horizontalrule, class-meta']

    body = lines[start:]

    # Remove leading blanks
    while body and body[0].strip() == "":
        body.pop(0)

    # Collect metadata after level-1 heading (and optional label line)
    meta: dict[str, str] = {}
    i = 0
    if i < len(body) and body[i].strip().startswith("="):
        i += 1
    if i < len(body) and body[i].strip().startswith("<"):
        i += 1
    while i < len(body):
        s = body[i].strip()
        if s.startswith("==") or s == "#horizontalrule":
            break
        if s.startswith("#strong[Date") or s.startswith("#strong[Topic") or s.startswith("#strong[Teacher"):
            meta.update(parse_meta_line(s))
            body.pop(i)
            continue
        if s == "":
            body.pop(i)
            continue
        break

    # Remove first horizontalrule before first ==
    i = 0
    while i < len(body):
        s = body[i].strip()
        if s == "#horizontalrule":
            body.pop(i)
            while i < len(body) and body[i].strip() == "":
                body.pop(i)
            break
        if s.startswith("=="):
            break
        i += 1

    # Remove trailing horizontalrule
    while body and body[-1].strip() == "":
        body.pop()
    if body and body[-1].strip() == "#horizontalrule":
        body.pop()
    while body and body[-1].strip() == "":
        body.pop()

    out_lines = imports + [""]
    if body:
        out_lines.append(body[0])
        if len(body) > 1 and body[1].strip().startswith("<"):
            out_lines.append(body[1])
            body = body[2:]
        else:
            body = body[1:]
    out_lines.extend(format_meta(meta))
    out_lines.extend(body)

    return "\n".join(out_lines) + "\n"


if __name__ == "__main__":
    path = Path(sys.argv[1])
    path.write_text(clean(path.read_text(encoding="utf-8")), encoding="utf-8")
