#import "mark.typ": mark
#import "annot.typ": annot
#import "arrow.typ": place-path-arrow

#set page(width: 6cm, height: 8cm, margin: (x: 24pt, y: 24pt))

$
mark(x) + mark(integral x^2 dif x)
$

$
2x + 3y + 4z = 4 \

mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(t, tag: #<y1>, color: #green)
+ mark(4, tag: #<c3>)mark(z, tag: #<z1>, color: #red)
= 4

#{
    annot(<c1>, alignment: top + left)[this is 2]
    annot(<c2>, alignment: top + center)[const.]
    annot(<c3>, alignment: top + right)[const.]
    annot(<x1>, alignment: bottom + left)[this is $x$]
    annot(<y1>, arrow-stroke: (thickness: 1pt, cap: "round"))[TTT]
    annot(<z1>, alignment: bottom + right)[this is $z$]
}

\


mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(y, tag: #<y1>, color: #green)
+ mark(4, tag: #<c3>)mark(z, tag: #<z1>, color: #red)
= 4

#{
    annot(<c1>, alignment: top + left)[this is 2]
    annot(<c2>, alignment: top + center)[const.]
    annot(<c3>, alignment: top + right)[const.]
    annot(<x1>, alignment: bottom + left)[this is $x$]
    annot(<y1>)[this is $y$]
    annot(<z1>, alignment: bottom + right)[this is $z$]
}

\

2x + 3y + 4z = 4
$

#place-path-arrow(stroke: 1pt + orange, (0pt, 0pt), (0pt, 10pt), (10pt, 10pt))
