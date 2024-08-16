#import "mark.typ": mark
#import "annot.typ": annot, alignannot

#set page(margin: (x: 24pt, y: 24pt))
#set text(size: 28pt)

$
mark(x) + mark(integral x^2 dif x)
$

$
mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(y, tag: #<y1>, color: #green)
= 4

#alignannot({
    annot(<c1>)[annotation]
    annot(<x1>, yshift: 1em)[annotation]
})

\

2x + 3y = 4
$
