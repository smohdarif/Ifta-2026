#!/usr/bin/env python3
"""Trim redundant horizontal rules at chapter start/end (pandoc artefacts)."""
import sys
from pathlib import Path


def clean(text: str) -> str:
    lines = text.splitlines()
    if not lines:
        return text

    # Keep import line(s) at top
    start = 0
    while start < len(lines) and lines[start].strip().startswith("#import"):
        start += 1

    body = lines[start:]

    # Remove leading blank lines and first #horizontalrule after title block
    i = 0
    while i < len(body) and body[i].strip() == "":
        i += 1
    # Skip = title and metadata lines until first horizontalrule
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

    # Remove trailing #horizontalrule (and blanks before it)
    while body and body[-1].strip() == "":
        body.pop()
    if body and body[-1].strip() == "#horizontalrule":
        body.pop()
    while body and body[-1].strip() == "":
        body.pop()

    return "\n".join(lines[:start] + body) + "\n"


if __name__ == "__main__":
    path = Path(sys.argv[1])
    path.write_text(clean(path.read_text(encoding="utf-8")), encoding="utf-8")
