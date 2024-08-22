#import "/src/mark.typ": mark
#import "/src/annot.typ": annot

#set page(width: 6cm, height: 24cm, margin: (x: .2cm, y: .2cm))
#let cell-pat = pattern(size: (10pt, 10pt))[
#place(line(start: (0%, 0%), end: (0%, 100%), stroke: silver))
#place(line(start: (0%, 0%), end: (1000%, 0%), stroke: silver))
]
#set page(fill: cell-pat)
// #show math.equation: set text(font: "STIX Two Math")


$
2x + 3y + 4z = 4 \

mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(y, tag: #<y1>, color: #green)
+ mark(4, tag: #<c3>)mark(z, tag: #<z1>, color: #red)
= 4

#{
  annot(<c1>, alignment: top + left)[this is 2]
  annot(<c2>, alignment: top + center)[const.]
  annot(<c3>, alignment: top + right)[const.]
  annot(<x1>, alignment: bottom + left)[this is $x$]
  annot(<y1>, arrow-stroke: (paint: red, thickness: 1pt, cap: "round"))[TTT]
  annot(<z1>, alignment: bottom + right, arrow-stroke: (dash: (1pt, .6pt)))[this is $z$]
}

\

mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(y, tag: #<y1>, color: #green)
+ mark(4, tag: #<c3>)mark(z, tag: #<z1>, color: #red)
= 4

#{
  annot(<c1>, alignment: top + left)[thi is 2]
  annot(<c2>, alignment: top + center)[h]
  annot(<c3>, alignment: top + right)[const.]
  annot(<x1>, alignment: bottom + left)[this is $x$]
  annot(<y1>, arrow-stroke: (paint: red, thickness: 1pt, cap: "round"))[TTT]
  annot(<z1>, alignment: bottom + right, arrow-stroke: (dash: (1pt, .6pt)))[this is $z$]
}

\

mark(x + 1, tag: #<num>) / mark(2, tag: #<den>)

#{
  annot(<num>, alignment: top + right)[Numerator]
  annot(<den>, alignment: right)[Denominator]
}

\

2x + 3y + 4z = 4 \

$
