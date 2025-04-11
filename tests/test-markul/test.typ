#import "/src/mark.typ": markul

$
  underline(x)
  markul(x)
  underline(y)
  markul(y)
$

$
  markul(x, color: #red)
  markul(x, stroke: #1pt)
  markul(x, color: #red, stroke: #1pt)
  markul(x, color: #red, stroke: #blue)
  markul(x, color: #red, stroke: #(blue + 1pt))
$

#[
  #set text(green)

  $
    underline(x)
    markul(x)
    markul(x, color: #red)
    markul(x, stroke: #1pt)
    markul(x, color: #red, stroke: #1pt)
    markul(x, color: #red, stroke: #blue)
    markul(x, color: #red, stroke: #(blue + 1pt))
  $
]

$
  markul(x, stroke: #(1pt + blue))
  markul(x, stroke: #(paint: green, dash: "dotted"))
$

$
  markul(x, outset: #(bottom: .3em))
  + markul(x, outset: #.3em)
$
