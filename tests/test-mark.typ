#import "/src/mark.typ": mark

// #set page(width: 12cm, height: 16cm, margin: (x: 24pt, y: 24pt))
#let cell-pat = pattern(size: (20pt, 20pt))[
  #place(line(start: (0%, 0%), end: (0%, 100%), stroke: silver))
  #place(line(start: (0%, 0%), end: (1000%, 0%), stroke: silver))
]
// #set page(fill: cell-pat)
#set heading(numbering: "1.")

// #show math.equation: set text(20pt)

#let rmark(body) = mark(body, color: red)
#let gmark(body) = mark(body, color: green)
#let bmark(body) = mark(body, color: blue)
#let boxmark(body) = mark(body, fill: none, stroke: .5pt)



= Color

#let color-list = (
  black,
  gray,
  silver,
  navy,
  blue,
  aqua,
  teal,
  eastern,
  purple,
  fuchsia,
  maroon,
  red,
  orange,
  yellow,
  olive,
  green,
  lime,
)
#let mark-list = color-list.map(c => mark(math.text("x"), color: c)).sum()

#text(20pt)[ $ #mark-list $ ]


= Fill / Stroke
$
  mark(x, fill: #none, stroke: #.5pt)
  mark(x, fill: #none, stroke: #(1pt + red), radius: #100%)
  mark(x, fill: #none, stroke: #(bottom: 2pt + blue))
$

= Padding
$
  mark(x, padding: #0pt) quad
  mark(x, padding: #0pt) quad
  mark(x, padding: #(x: 8pt, y: 4pt)) quad
  mark(x, padding: #(left: 4pt, right: 2pt, top: 6pt, bottom: 8pt)) quad
  mark(x, padding: #(right: 0pt, rest: 4pt))
$


= Size / position
== Block
$
  mark(x, padding: #0pt)
  mark(y, padding: #0pt)
  mark(T, padding: #0pt)
  mark(text(x, size: #2em), padding: #0pt)
  mark(text(x, size: #40pt), padding: #0pt)
  x_mark(x, padding:#0pt)
  x_x_mark(x, padding:#0pt)
  x^mark(x, padding:#0pt)
  x^x^mark(x, padding:#0pt)
$

$
  mark(x y T) \
  mark(x + y) \
  mark(x + integral x dif x) \
  mark(x + vec(1, 2, delim: "[")) \
  mark(x + vec(1, 2, delim: "[") + vec(1, 2, 3, delim: "{")) \
  mark(x + mat(1, 2; 3, 4; delim: "[")) \
  mark(x_(1+p)^T) x_rmark(i + 1)_bmark(j + 1)_gmark(k + 1) x^rmark(i + 1)^bmark(j + 1)^gmark(k + 1) \
$
== Inline
$mark(x)$
$mark(y)$
$mark(T)$
$mark(x y T)$
$mark(x + y)$
$mark(x + integral x dif x)$
$mark(x + vec(1, 2, delim: "["))$
$mark(x + vec(1, 2, delim: "[") + vec(1, 2, 3, delim: "{"))$
$mark(x + mat(1, 2; 3, 4; delim: "["))$
$mark(x_(1+p)^T) x_rmark(i + 1)_bmark(j + 1)_gmark(k + 1) x^rmark(i + 1)^bmark(j + 1)^gmark(k + 1)$

$mark(#{
  for i in range(30) {
    $x + $
  }
  $x$
})$

#lorem(30)
$mark(x + y + T)$
#lorem(20)


= Nesting
$
  boxmark(mark(x) + y) \
  boxmark(x + mark(y)) \
  boxmark(mark(gmark(x) + bmark(y)) + z) \
  boxmark(boxmark(mark(gmark(x) + bmark(y)) + z) + t) \
$

// $
//   boxmark(boxmark(x) + boxmark(integral boxmark(x) dif x) + boxmark(y)) \
// $


= Layout

$
  x \
  x \
  mark(x) \
$

$
  x + 1 \
  mark(x + 1) \
  mark(x) + 1 \
  x + mark(1) \
  mark(x) + mark(1) \
$

$
  x + integral x dif x \
  mark(x + integral x dif x) \
$

$
  x + vec(1, 2, delim: "[") + vec(1, 2, 3, delim: "{") \
  mark(x + vec(1, 2, delim: "[") + vec(1, 2, 3, delim: "{")) \
$

$
  x < integral_0^1 x dif x \
  mark(x < integral_0^1 x dif x) \
$

$
  x + x_1 + x_1 \
  mark(x + x_1 + x_1)
$

$
  x y z \
  mark(x y z) \
  x mark(y) z \
  rmark(x) gmark(y) bmark(z) \
$

$
  2 x + 3 y = 4 \
  mark(2 x + 3 y = 4) \
  mark(2) gmark(x) + rmark(3) bmark(y) = mark(4)
$

$
  x dif x \
  mark(x dif x) \
  // rmark(x) dif bmark(x) \
  rmark(x) dif bmark(x) \
  rmark(x) gmark(dif) bmark(x) \
$

$
  L / T + mark(L) / mark(T) + mark(L / T) \
  L_1 / T^1 + mark(L_1) / mark(T^1) + mark(L_1 / T^1) \
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
