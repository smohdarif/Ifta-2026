// ═══════════════════════════════════════════════════════════════
//  Masā'il al-Ḥajj — Islamic-themed book layout (Typst)
// ═══════════════════════════════════════════════════════════════

#let book-title = "Masā'il al-Ḥajj"
#let book-subtitle = "Conditions of Obligatory Hajj — Class Notes"
#let book-edition = "First edition · 2026 (ongoing)"

#let school-name = "Darul Uloom Wal Funoon"
#let teacher-name = "Mufti Umar Aejaz"
#let compiler-name = "Arif Shaikh"

#let source-title-ar = "بَدَائِعُ الصَّنَائِعِ فِي تَرْتِيبِ الشَّرَائِعِ"
#let source-title-en = "Badāʾiʿ al-Ṣanāʾiʿ fī Tartīb al-Sharāʾiʿ"
#let source-vol = "Volume 3 (al-Iʿtikāf — al-Nikāḥ)"
#let source-author-ar = "الإمام علاء الدين أبو بكر بن مسعود الكاساني"
#let source-author-en = "Imam ʿAlāʾ al-Dīn Abū Bakr ibn Masʿūd al-Kāsānī (d. 587 AH)"

// ── Palette (warm parchment + emerald + gold) ─────────────────
#let bg-parchment = rgb("#f8f4eb")
#let bg-card = rgb("#fffdf8")
#let ink-body = rgb("#2a2418")
#let ink-muted = rgb("#5c5345")
#let green-deep = rgb("#0f4d3f")
#let green-mid = rgb("#1a6b58")
#let green-soft = rgb("#d8ebe4")
#let gold = rgb("#a67c2e")
#let gold-light = rgb("#e8d4a8")
#let rule-color = rgb("#c9b896")

#let body-font = "Libertinus Serif"
#let arabic-font = ("Amiri", "Arial Unicode MS")
#let heading-font = "Libertinus Serif"

#let page-margin = (
  top: 2.6cm,
  bottom: 2.8cm,
  inside: 2.6cm,
  outside: 2.2cm,
)

// ── Ornaments ─────────────────────────────────────────────────
#let ornament-line(width: 100%) = {
  box(width: width)[
    #align(center)[
      #text(fill: gold, size: 11pt)[◆]
      #h(0.4em)
      #line(length: 35%, stroke: 0.6pt + gold)
      #h(0.35em)
      #text(fill: green-mid, size: 9pt)[✦]
      #h(0.35em)
      #line(length: 35%, stroke: 0.6pt + gold)
      #h(0.4em)
      #text(fill: gold, size: 11pt)[◆]
    ]
  ]
}

#let side-rule() = place(
  left + horizon,
  dx: -1.6cm,
  rect(
    width: 3pt,
    height: 1.4em,
    fill: gradient.linear(green-deep, gold, angle: 90deg),
    radius: 2pt,
  ),
)

#let chapter-banner(title, subtitle: none) = {
  block(
    width: 100%,
    fill: gradient.linear(green-soft, bg-card, angle: 90deg),
    stroke: 0.75pt + green-mid.lighten(50%),
    radius: 6pt,
    inset: (x: 16pt, y: 14pt),
    below: 1.4em,
  )[
    #text(font: arabic-font, size: 13pt, fill: green-deep)[بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ]
    #v(0.7em)
    #ornament-line(width: 55%)
    #v(0.8em)
    #text(font: heading-font, size: 17pt, weight: "bold", fill: green-deep)[#title]
    #if subtitle != none [
      #v(0.35em)
      #text(size: 10.5pt, fill: ink-muted, style: "italic")[#subtitle]
    ]
  ]
}

// ── Arabic & quote blocks ─────────────────────────────────────
#let arabic-block(body) = {
  set text(font: arabic-font, lang: "ar", size: 12pt, fill: green-deep)
  set align(right)
  set par(leading: 0.85em, spacing: 1.1em)
  block(
    fill: bg-card,
    stroke: (left: 2.5pt + green-mid),
    inset: (left: 14pt, rest: 10pt),
    radius: (right: 4pt),
    width: 100%,
  )[#body]
}

#let english-block(body) = {
  set text(font: body-font, lang: "en", size: 10pt, style: "italic", fill: ink-muted)
  set par(leading: 0.7em)
  body
}

#let ayah-block(arabic, translation, ref) = {
  block(
    fill: bg-card,
    stroke: 0.5pt + rule-color,
    inset: 14pt,
    radius: 6pt,
    width: 100%,
    spacing: 1em,
  )[
    #arabic-block[#arabic]
    #v(0.55em)
    #english-block[#translation]
    #v(0.4em)
    #text(size: 8.5pt, fill: gold.darken(15%))[— #ref]
  ]
}

// ── Document setup ────────────────────────────────────────────
#let setup-document() = {
  set document(
    title: book-title,
    author: (compiler-name, teacher-name),
    keywords: ("Hajj", "Hanafi fiqh", "Masail", school-name),
  )

  set page(
    paper: "a5",
    fill: bg-parchment,
    margin: page-margin,
    numbering: none,
    header: context {
      let pg = counter(page).get().first()
      if pg > 2 [
        #set text(size: 8pt, fill: ink-muted)
        #grid(
          columns: (1fr, auto, 1fr),
          align: (left, center, right),
          [#book-title],
          [#text(fill: gold)[◆]],
          [#school-name],
        )
        #v(0.15em)
        #line(length: 100%, stroke: 0.4pt + rule-color)
      ]
    },
    footer: context {
      let pg = counter(page).get().first()
      if pg > 2 [
        #v(0.15em)
        #line(length: 100%, stroke: 0.4pt + rule-color)
        #v(0.25em)
        #align(center)[
          #text(size: 9pt, fill: ink-muted)[
            #counter(page).display("1", 1)
          ]
        ]
      ]
    },
  )

  set text(
    font: body-font,
    size: 11pt,
    lang: "en",
    fill: ink-body,
    hyphenate: true,
  )

  set par(
    justify: true,
    leading: 0.75em,
    spacing: 1.35em,
    first-line-indent: 0pt,
  )

  set heading(numbering: none)

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    chapter-banner(it.body)
  }

  show heading.where(level: 2): it => {
    v(1.1em)
    block(below: 0.75em)[
      #side-rule()
      #pad(left: 0.5em)[
        #text(font: heading-font, size: 13.5pt, weight: "bold", fill: green-deep)[#it.body]
      ]
      #v(0.35em)
      #line(length: 100%, stroke: 0.5pt + green-soft.darken(10%))
    ]
  }

  show heading.where(level: 3): it => {
    v(0.85em)
    text(font: heading-font, size: 12pt, weight: "semibold", fill: green-mid)[#it.body]
    v(0.35em)
  }

  show heading.where(level: 4): it => {
    v(0.6em)
    text(font: heading-font, size: 11pt, weight: "semibold", fill: ink-body)[#it.body]
    v(0.25em)
  }

  set list(
    indent: 1.4em,
    body-indent: 0.55em,
    spacing: 0.55em,
  )
  set enum(
    indent: 1.4em,
    body-indent: 0.55em,
    spacing: 0.55em,
  )

  show list.item: it => {
    pad(y: 0.12em)[#it]
  }

  show quote: it => {
    block(
      fill: bg-card,
      stroke: (left: 3pt + gold),
      inset: (left: 14pt, rest: 12pt),
      radius: (right: 5pt),
      spacing: 0.9em,
      width: 100%,
    )[
      #set text(size: 10.5pt, fill: ink-body)
      #set par(leading: 0.72em, spacing: 1.1em)
      #it
    ]
  }

  show table: set text(size: 9.75pt)
  show table: set par(leading: 0.55em, spacing: 0.9em)
  show table.cell.where(y: 0): set text(
    weight: "bold",
    fill: green-deep,
    size: 9.5pt,
  )
  show table.cell.where(y: 0): set table.cell(
    fill: green-soft,
  )
  show table.cell: set table.cell(inset: 9pt)
  show table: set table(
    stroke: (
      x: none,
      y: 0.5pt + rule-color,
      top: 1pt + green-mid,
      bottom: 1pt + green-mid,
    ),
  )

  show strong: set text(fill: green-deep, weight: "bold")
  show emph: set text(fill: green-mid.darken(10%))
  show link: it => underline(stroke: 0.4pt + green-mid)[#text(fill: green-mid)[#it]]
  show figure: set text(size: 9pt, fill: ink-muted)
}

// Pandoc emits #horizontalrule (no parentheses) between sections
#let horizontalrule = [
  #v(0.8em)
  #ornament-line()
  #v(0.8em)
]

// ── Front pages ───────────────────────────────────────────────
#let title-page() = {
  set page(fill: gradient.linear(bg-parchment, green-soft.lighten(75%), angle: 160deg))
  set page(header: none, footer: none, numbering: none)

  v(0.6fr)
  align(center)[
    #block(
      width: 88%,
      fill: bg-card.transparentize(10%),
      stroke: 1pt + gold.lighten(30%),
      radius: 10pt,
      inset: 28pt,
    )[
      #text(font: arabic-font, size: 15pt, fill: green-deep)[
        بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
      ]
      #v(1.2em)
      #ornament-line(width: 70%)
      #v(1.4em)
      #text(font: heading-font, size: 10.5pt, tracking: 0.08em, fill: green-mid)[#school-name]
      #v(1.2em)
      #text(font: heading-font, size: 24pt, weight: "bold", fill: green-deep)[#book-title]
      #v(0.45em)
      #text(font: heading-font, size: 13pt, fill: ink-muted)[#book-subtitle]
      #v(1em)
      #text(size: 10.5pt, style: "italic", fill: ink-muted)[
        Compiled class notes · Ḥanafī fiqh of Hajj
      ]
      #v(1.6em)
      #grid(
        columns: (1fr, 1fr),
        gutter: 16pt,
        [
          #align(left)[
            #text(size: 8.5pt, weight: "bold", fill: gold)[TEACHER]
            #v(0.2em)
            #text(size: 10.5pt)[#teacher-name]
          ]
        ],
        [
          #align(left)[
            #text(size: 8.5pt, weight: "bold", fill: gold)[COMPILED BY]
            #v(0.2em)
            #text(size: 10.5pt)[#compiler-name]
          ]
        ],
      )
      #v(1.4em)
      #text(size: 9.5pt, fill: ink-muted)[#book-edition]
    ]
  ]
  v(1fr)
  pagebreak()
}

#let copyright-page() = {
  set page(numbering: none, header: none, footer: none)
  v(0.5fr)
  block(
    width: 100%,
    fill: bg-card,
    stroke: 0.5pt + rule-color,
    radius: 8pt,
    inset: 20pt,
  )[
    #text(size: 12pt, weight: "bold", fill: green-deep)[Copyright & notice]
    #v(0.8em)
    #set par(spacing: 1.2em, leading: 0.72em)
    #set text(size: 9.75pt, fill: ink-body)

    These notes are prepared for students of *#school-name* following the Masā'il al-Ḥajj series with *#teacher-name*. They are study material, not a formal fatwa unless endorsed by the institution.

    *Disclaimer.* Content reflects live class instruction in the Ḥanafī madhhab. Consult qualified scholars for legal rulings.

    *Reference text.* The principal Hanafi reference for this series is *#source-title-en* (#source-vol), by #source-author-en.

    *Ongoing edition.* New sessions will be added as classes continue.

    #v(1.2em)
    #align(right)[
      #text(fill: ink-muted)[© 2026 · #compiler-name]
    ]
  ]
  v(1fr)
  pagebreak()
}

#let start-body-pages() = {
  set page(numbering: "1")
  counter(page).update(1)
}
