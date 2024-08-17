#import "mark.typ": mark
#import "annot.typ": annot
#import "arrow.typ": place-path-arrow

#set page(width: 6cm, height: 8cm, margin: (x: 24pt, y: 24pt))

$
mark(x) + mark(integral x^2 dif x)
$

$
mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(y, tag: #<y1>, color: #green)
= 4

#{
    annot(<x1>, yshift: 1.5em)[this is $x$]
    annot(<c1>)[const.]
    annot(<y1>)[this is $y$]
}

\

2x + 3y = 4
$

#place-path-arrow(stroke: 1pt + orange, (0pt, 0pt), (0pt, 10pt), (10pt, 10pt))
