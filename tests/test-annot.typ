#import "/src/mark.typ": mark, mannot-init
#import "/src/annot.typ": annot

#set page(width: 10cm, height: 24cm, margin: (x: .2cm, y: .2cm))

#let rmark = mark.with(color: red)
#let gmark = mark.with(color: green)
#let bmark = mark.with(color: blue)

#show: mannot-init

$
  #v(1em) \
  mark(x, tag: #<x>) \
  #v(1em)

  #{
    annot(<x>)[T]
    annot(<x>, alignment: top)[y]
  }
$

$
  mark(2, tag: #<c1>) rmark(x, tag: #<x1>)
  + mark(3, tag: #<c2>) gmark(y, tag: #<y1>)
  + mark(4, tag: #<c3>) bmark(z, tag: #<z1>)
  = 4 \

  #{
    annot(<c1>, alignment: top + left)[top left]
    annot(<c2>, alignment: top + center)[top center]
    annot(<c3>, alignment: top + right)[top right]
    annot(<x1>, alignment: bottom + left)[bottom left]
    annot(<y1>, alignment: bottom + center)[bottom center]
    annot(<z1>, alignment: bottom + right)[bottom right]
  }
$

$
  mark(2, tag: #<c1>) rmark(x, tag: #<x1>)
  + mark(3, tag: #<c2>) gmark(y, tag: #<y1>)
  + mark(4, tag: #<c3>) bmark(z, tag: #<z1>)
  = 4 \

  #{
    annot(<c1>, alignment: top + left, yshift: .6em)[top left]
    annot(<c2>, alignment: top + center, yshift: .6em)[top center]
    annot(<c3>, alignment: top + right, yshift: .6em)[top right]
    annot(<x1>, alignment: bottom + left, yshift:.6em)[bottom left]
    annot(<y1>, alignment: bottom + center, yshift:.6em)[bottom center]
    annot(<z1>, alignment: bottom + right, yshift:.6em)[bottom right]
  }
$

$
  mark(x + 1, tag: #<num>) / bmark(2, tag: #<den>)

  #{
    annot(<num>, alignment: top + right)[Numerator]
    annot(<den>, alignment: right)[Denominator]
  }
$

$
  integral_rmark(0, tag: #<i0>)^bmark(1, tag: #<i1>)
  mark(x^2 + 1, tag: #<i2>) dif gmark(x, tag: #<i3>)

  #{
    annot(<i0>)[Start]
    annot(<i1>, alignment: top)[End]
    annot(<i2>, alignment: top + right)[Integrand]
    annot(<i3>, alignment: right)[Variable]
  }
$
