#import "/src/mark.typ": markul
#import "/src/util.typ": copy-stroke

$
  underline(x)
  markul(x)
  underline(y)
  markul(y)
$

$
  markul(x, color: #red)
$

#[
  #set text(red)

  $
    underline(x)
    markul(x)
    markul(x, stroke: #(dash: "dotted"))
  $
]

$
  markul(x, stroke: #(1pt + blue))
  markul(x, stroke: #(paint: green, dash: "dotted"))
$

$
  markul(x, outset: #(bottom: .3em))
$
