#import "/src/mark.typ": mark
#import "/src/annot.typ": annot

#set page(width: 6cm, height: 24cm, margin: (x: .2cm, y: .2cm))
#let cell-pat = pattern(size: (10pt, 10pt))[
#place(line(start: (0%, 0%), end: (0%, 100%), stroke: silver))
#place(line(start: (0%, 0%), end: (1000%, 0%), stroke: silver))
]
#set page(fill: cell-pat)
// #show math.equation: set text(font: "STIX Two Math")
#set math.equation(numbering: "(1)")

#let rmark = mark.with(color: red)
#let gmark = mark.with(color: green)
#let bmark = mark.with(color: blue)


#rect(width: 100%)[$
mark(2, tag: #<c1>)rmark(x, tag: #<x1>)
+ mark(3, tag: #<c2>)gmark(y, tag: #<y1>)
+ mark(4, tag: #<c3>)bmark(z, tag: #<z1>)
= 4

#{
  annot(<c1>, alignment: top + left)[top left]
  annot(<c2>, alignment: top + center)[top center]
  annot(<c3>, alignment: top + right)[top right]
  annot(<x1>, alignment: bottom + left)[bottom left]
  annot(<y1>, alignment: bottom + center)[bottom center]
  annot(<z1>, alignment: bottom + right)[bottom right]
}
$]


#rect(width: 100%)[$
mark(x + 1, tag: #<num>) / bmark(2, tag: #<den>)

#{
  annot(<num>, alignment: top + right)[Numerator]
  annot(<den>, alignment: right)[Denominator]
}
$]


#rect(width: 100%)[$
integral_rmark(0, tag: #<i0>)^bmark(1, tag: #<i1>)
mark(x^2 + 1, tag: #<i2>) dif""gmark(x, tag: #<i3>)

#{
  annot(<i0>)[Start]
  annot(<i1>, alignment: top)[End]
  annot(<i2>, alignment: top + right)[Integrand]
  annot(<i3>, alignment: right)[Variable]
}
$]


#rect(width: 100%)[$
2 x &+ 3 y &+ 4 z &= 5 \
mark(22 x &+ 33 y, tag: #<e1>) & &= 55 \
rmark(x, tag: #<x2>) & &+ gmark(44 z, tag: #<z2>) &= bmark(5) \

#{
  annot(<e1>)[Containing align-point()]
  annot(<x2>)[This is $x$.]
  annot(<z2>, alignment: top)[Term]
}
$]


#rect(width: 100%)[$
mark(x, tag: #<x3>)

#{
  annot(<x3>, alignment: top)[Top]
}
$]


// privateなラベルシステムを作る関数を作ればいいのでは？
