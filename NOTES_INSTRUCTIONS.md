# Instructions for Masail e Hajj Class Notes

Use this file whenever creating or updating class notes in this repository.

---

## Filename

```
May DD YYYY - Masail e Hajj - Class N - Short topic.md
```

- **Date first** — class date, not upload date.
- **Class number** — sequential (1, 2, 3…).
- **Short topic** — a few words from the main subject (e.g. `Zad and Rahila`, `Amn al-Tariq and Women's Conditions`).

---

## File header (required)

```markdown
# Masail e Hajj — Class N Summary

**Date:** May DD, YYYY  
**Topic:** …  
**Teacher:** Mufti Omar Sahab

---
```

---

## Writing style

1. **Human, clear prose** — like good study notes, not a transcript dump.
2. **Hard / technical terms** — give Arabic where relevant, then English in **brackets** on first use, e.g. **Istita’at (استطاعة)** [capability to perform Hajj].
3. **Structure** — use `##` for main sections, `###` for subsections, bullets for lists, `---` between major parts.
4. **Opinions** — name the scholar(s), state the **preferred (mufta bihi / mashhur)** Hanafi view when the teacher gives it, and give brief **reasoning**.
5. **Cases** — use “Case 1 / Case 2” or Q&A blocks for scenarios from class.
6. **Do not invent** rulings or references not taught in class; if unsure, note “as discussed in class” without a false citation.

---

## Arabic ibarat (required when the teacher quotes or relies on a text)

For each important **Quranic verse**, **hadith**, or **fiqh phrase** discussed:

1. Give the **Arabic with full vowelling (a’rab / tashkeel)** where possible.
2. Add a **short English meaning** below or beside it.
3. Add a **reference** when known (see below).

Example:

```markdown
> لَا يَحِلُّ لِامْرَأَةٍ تُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الْآخِرِ أَنْ تُسَافِرَ مَسِيرَةَ يَوْمٍ وَلَيْلَةٍ إِلَّا مَعَ ذِي مَحْرَمٍ
>
> *“It is not lawful for a woman who believes in Allah and the Last Day to travel a distance of one day and one night except with a mahram.”*
>
> **Ref:** Sahih al-Bukhari, 1088; Sahih Muslim, 1341 (hadith of Ibn ‘Abbas رضي الله عنه).
```

---

## References (use when discussed or clearly implied)

| Source | Format |
|--------|--------|
| Quran | Surah name, ayah number — e.g. *Aal Imran: 97* |
| Bukhari | *Sahih al-Bukhari*, hadith number |
| Muslim | *Sahih Muslim*, hadith number |
| Other hadith books | Book name, number if known; otherwise “narrated in class — verify numbering” |
| Fiqh texts | Book + section if teacher names it (e.g. *al-Hidayah*) |

If the teacher quotes wording but not a number, include the Arabic + meaning and note: **(hadith as cited in class — confirm in hadith index)**.

---

## Typical sections (adapt per class)

- Introduction / background (what condition or mas’alah is being studied)
- Key terms
- Main opinions (Hanafi preferred vs other madhahib if taught)
- Evidence: Quran, hadith, logic (`‘aql)
- Comparison tables (e.g. Zad vs Rahila vs Amn)
- Detailed cases / scenarios
- Q&A from students (verbatim question + teacher’s answer, simplified)
- Closing / next class topic and time

---

## After writing

1. Save with the correct **filename** in the repo root (same folder as other class files).
2. **Commit message** pattern: `Add Masail e Hajj Class N notes: [short topic]`
3. Push to `origin main` only when the user asks to push.
4. Rebuild the book PDF: `./book/build.sh` → output at `book/output/Masail-e-Hajj.pdf`

## Book (Typst PDF)

- **Theme:** Islamic palette (parchment, emerald, gold) — see `book/lib.typ`
- **School:** Darul Uloom Wal Funoon
- **Teacher:** Mufti Umar Aejaz
- **Compiled by:** Arif Shaikh
- **Reference text:** *Badā'iʿ al-Ṣanā'iʿ* (al-Kāsānī), vol. 3

---

## Related files in this repo

| Class | File |
|-------|------|
| 1 | `May 11 2026 - Masail e Hajj - Class 1 - Conditions That Make Hajj Obligatory.md` |
| 2 | `May 12 2026 - Masail e Hajj - Class 2 - Istitaat and the Blind Person.md` |
| 3 | `May 13 2026 - Masail e Hajj - Class 3 - Zad and Rahila.md` |
| 4 | `May 18 2026 - Masail e Hajj - Class 4 - Amn al-Tariq and Women's Conditions.md` |
| 5 | `May 19 2026 - Masail e Hajj - Class 5 - Iddah Travel Restrictions and Hajj Badal.md` |
| 6 | `May 21 2026 - Masail e Hajj - Class 6 - Wuquf Arafah Obligation Place and Timing.md` |
| 7 | `May 22 2026 - Masail e Hajj - Class 7 - Wuquf Arafah Duration Departure and Udhiyah.md` |
| 8 | `May 23 2026 - Masail e Hajj - Class 8 - Ahkam e Eid ul Azha and Qurbani.md` |
| 9 | `June 1 2026 - Masail e Hajj - Class 9 - Tawaf al-Ziyarah Obligation and Rukn.md` |
| 10 | `June 2 2026 - Masail e Hajj - Class 10 - Taharat and Wajibat of Tawaf.md` |
| 11 | `June 3 2026 - Masail e Hajj - Class 11 - Tawaf al-Ziyarah Sunan Timing and Rulings.md` |
| 12 | `June 8 2026 - Masail e Hajj - Class 12 - Sai Status Wajibat and Penalty Framework.md` |
| 13 | `June 9 2026 - Masail e Hajj - Class 13 - Sai Conditions Timing and Missed Rulings.md` |
| 14 | `May 24 2026 - Masail e Qurbani - Class 2 - Defects Method and Distribution.md` |

Update this table when adding new classes.
