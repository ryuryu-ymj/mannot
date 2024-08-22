#import "/src/mark.typ": mark

// #set page(width: 12cm, height: 16cm, margin: (x: 24pt, y: 24pt))
#set heading(numbering: "1.")

#show math.equation: set text(20pt)
#show link: underline

#let rmark(body) = mark(body, color: red)
#let gmark(body) = mark(body, color: green)
#let bmark(body) = mark(body, color: blue)


= Check color

#let color-list = (black, gray, silver, navy, blue, aqua, teal, eastern, purple, fuchsia, maroon, red, orange, yellow, olive, green, lime)
#let mark-list = color-list.map(
  (c) => mark(math.text("x"), color: c)
).sum()

#text(20pt)[ $ #mark-list $ ]


= Check other properties
$
mark(x, fill: #none, stroke: #.5pt)
mark(x, fill: #none, stroke: #(bottom: 1pt + red))
mark(x, fill: #red, radius: #100%) \
mark(x, padding: #(x: 8pt, y: 4pt)) quad
mark(x, padding: #(left: 4pt, right: 2pt, top: 6pt, bottom: 8pt)) quad
mark(x, padding: #(right: 0pt, rest: 4pt))
$


= Check size and position
$
mark(x y T) \
mark(x dif x) \
mark(x + integral x dif x) \
mark(x + vec(1, 2, delim: "[")) \
mark(x + vec(1, 2, delim: "[") + vec(1, 2, 3, delim: "{")) \
mark(x + mat(1, 2; 3, 4; delim: "[")) \
$

= Check nesting
$
mark(gmark(x) + bmark(y) + z) \
mark(bmark(integral x dif x) + gmark(integral x dif x) + x) \
// mark(gmark(rmark(x)))  // Error!
$


#let cell-pat = pattern(size: (20pt, 20pt))[
#place(line(start: (0%, 0%), end: (0%, 100%), stroke: silver))
#place(line(start: (0%, 0%), end: (1000%, 0%), stroke: silver))
]
#set page(fill: cell-pat)

= Check layout

$
x \
mark(x)
$

$
2 x + 3 y = 4 \
mark(2 x + 3 y = 4) \
mark(2)gmark(x) + rmark(3)bmark(y) = mark(4)
$

$
x dif x \
mark(x dif x) \
// rmark(x) dif bmark(x) \
rmark(x) dif#{}bmark(x) \
rmark(x) gmark(dif)bmark(x) \
$

Align-point:
$
2 x &+ 3 y &+ 4 z &= 5 \
mark(2 x &+ 3 y &+ 4 z &= 5) \
rmark(2 x) &+ gmark(3 y) &+ bmark(4 z) &= mark(5) \

22 x &+ 33 y & &= 55 \
mark(22 x &+ 33 y & &= 55) \
rmark(22 x) &+ gmark(33 y) & &= bmark(55) \

x & &+ 44 z &= 5 \
mark(x & &+ 44 z &= 5) \
rmark(x) & &+ gmark(44 z) &= bmark(5) \
$

User-defined function:
#let dfrac(a, b) = $( dif#a ) / ( dif#b )$
$
1 + dfrac(a, b) \
mark(1 + dfrac(a, b)) \
1 + dfrac(rmark(a), gmark(b))
$

Horizontal spacing:
$
x #h(1em, weak: true) y #h(1em, weak: true) x \
x mark(#h(1em, weak: true) y #h(1em, weak: true)) x \
x mark(#h(1em) y #h(1em)) x \
mark(x #h(1em, weak: true) y #h(1em, weak: true) x) \
$


== Spacing issue

$
x y z \
x mark(y) z \
x""mark(y)z \
$

This is because unexpected space will be inserted
between context and text:
$
x y z \
x #context{$y$} z \
x
#{context{place(rect())} + context{$y$}}
z \
$

This issue may be fixed near future:
(
https://github.com/typst/typst/issues/4326
,
https://github.com/typst/typst/pull/4348
).
