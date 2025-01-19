#import "/src/mark.typ": mark
#import "/src/annot.typ": annot

#set page(width: 10cm, height: 10cm, margin: (x: .2cm, y: .2cm))

#let rmark = mark.with(color: red)
#let gmark = mark.with(color: green)
#let bmark = mark.with(color: blue)


$
  #v(1em) \
  mark(x, tag: #<x>) \
  #v(1em)

  #{
    annot(<x>)[T]
    annot(<x>, pos: top)[p]
  }
$

$
  #v(1em) \
  mark(2, tag: #<c1>) rmark(x, tag: #<x1>)
  + mark(3, tag: #<c2>) gmark(y, tag: #<y1>)
  + mark(4, tag: #<c3>) bmark(z, tag: #<z1>)
  = 4 \
  #v(1em)

  #{
    annot(<c1>, pos: top + left     )[left \ top left]
    annot(<c2>, pos: top + center   )[center \ top center]
    annot(<c3>, pos: top + right    )[right \ top right]
    annot(<x1>, pos: bottom + left  )[bottom left \ left]
    annot(<y1>, pos: bottom + center)[bottom center \ center]
    annot(<z1>, pos: bottom + right )[bottom right \ right]
  }
$

$
  #v(1em) \
  mark(2, tag: #<c1>) rmark(x, tag: #<x1>)
  + mark(3, tag: #<c2>) gmark(y, tag: #<y1>)
  + mark(4, tag: #<c3>) bmark(z, tag: #<z1>)
  = 4 \
  #v(1em)

  #{
    annot(<c1>, pos: top + left     , yshift: .6em)[left \ top left]
    annot(<c2>, pos: top + center   , yshift: .6em)[center \ top center]
    annot(<c3>, pos: top + right    , yshift: .6em)[right \ top right]
    annot(<x1>, pos: bottom + left  , yshift: .6em)[bottom left \ left]
    annot(<y1>, pos: bottom + center, yshift: .6em)[bottom center \ center]
    annot(<z1>, pos: bottom + right , yshift: .6em)[bottom right \ right]
  }
$

$
  mark(x + 1, tag: #<num>) / bmark(2, tag: #<den>)

  #{
    annot(<num>, pos: top + right)[Numerator]
    annot(<den>, pos: right)[Denominator]
  }
$

$
  integral_rmark(0, tag: #<i0>)^bmark(1, tag: #<i1>)
  mark(x^2 + 1, tag: #<i2>) dif gmark(x, tag: #<i3>)

  #{
    annot(<i0>)[Begin]
    annot(<i1>, pos: top)[End]
    annot(<i2>, pos: top + right)[Integrand]
    annot(<i3>, pos: right)[Variable]
  }
$

#pagebreak()

$
  x \
  mark(x, tag: #<x>)

  #annot(<x>)[annotation]
$

$
  x + y \
  mark(x, tag: #<x>)
  #annot(<x>)[annotation1]
  + mark(y)
  #annot(<x>, pos: top)[annotation2]
$
