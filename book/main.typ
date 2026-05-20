#import "lib.typ": *

#setup-document()

// ── Front matter (roman-style feel, unnumbered headers) ───────
#title-page()
#copyright-page()
#include "frontmatter.typ"

// ── Body ──────────────────────────────────────────────────────
#start-body-pages()

#include "chapters/class-01.typ"
#include "chapters/class-02.typ"
#include "chapters/class-03.typ"
#include "chapters/class-04.typ"

// ── Back matter ───────────────────────────────────────────────
#pagebreak()
#chapter-banner(
  [Index of Topics],
  subtitle: [Major sections in this edition],
)

#outline(
  title: none,
  target: heading.where(level: 2),
  indent: 1.2em,
)

#v(2em)
#align(center)[
  #ornament-line(width: 40%)
  #v(0.8em)
  #text(size: 9.5pt, fill: ink-muted, style: "italic")[
    End of edition · Further sessions forthcoming \
    #school-name · #teacher-name
  ]
]
