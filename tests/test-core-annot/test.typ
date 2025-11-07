#import "/src/mark.typ": mark
#import "/src/annot.typ": core-annot

#let annot(tag) = core-annot(tag, markers => {
  rect([ #markers ])
})

$
  mark(x, tag: #<x>)
  #annot(<x>)
$
#annot(<x>)

#pagebreak()

$
  mark(x, tag: #<x>) + mark(y, tag: #<y>)
  #annot((<x>, <y>))
$
#annot((<x>, <y>))
