#import "/src/mark.typ": mark
#import "/src/annot.typ": core-annot

// #set page(width: 12cm, height: 10cm)
#let annot(tag) = core-annot(tag, markers => {
  [ #markers ]
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
  let bounds = markers.first().anchor-bounds
  place(
    rect(width: bounds.width, height: bounds.height, fill: red.transparentize(60%)),
    dx: bounds.x,
    dy: bounds.y,
  )
})
#let annot-stroke(tag) = core-annot(tag, markers => {
  let bounds = markers.first().anchor-bounds
  place(
    rect(width: bounds.width, height: bounds.height),
    dx: bounds.x,
    dy: bounds.y,
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
