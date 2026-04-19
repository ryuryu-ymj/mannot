#import "/src/mark.typ": mark
#import "/src/annot.typ": core-annot

#set page(width: 12cm, height: 10cm)
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

#pagebreak()

#let annot-fill(tag) = core-annot(tag, markers => {
  place(
    rect(width: markers.first().width, height: markers.first().height, fill: red.transparentize(60%)),
    dx: markers.first().x,
    dy: markers.first().y,
  )
})
#let annot-stroke(tag) = core-annot(tag, markers => {
  place(
    rect(width: markers.first().width, height: markers.first().height),
    dx: markers.first().x,
    dy: markers.first().y,
  )
})

$
  mark(x, tag: #<1>)
  + mark(integral x dif x, tag: #<2>)
  #annot-fill(<1>)
  #annot-fill(<2>)
$
#annot-stroke(<1>)
#annot-stroke(<2>)

$
  mark(x + mark(y + z, tag: #<2>), tag: #<1>)
  #annot-fill(<1>)
  #annot-fill(<2>)
$
#annot-stroke(<1>)
#annot-stroke(<2>)
