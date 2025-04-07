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

$
  markul(x, stroke: #(1pt + blue))
  markul(x, stroke: #(paint: green, dash: "dotted"))
$

$
  markul(x, padding: #.3em)
$
