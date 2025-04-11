#import "/src/mark.typ": markrect


$
  markrect(x)
$

$
  markrect(x, color: #red)
  + markrect(x, stroke: #1pt)
  + markrect(x, color: #red, stroke: #1pt)
  + markrect(x, color: #red, stroke: #blue)
  + markrect(x, color: #red, stroke: #(blue + 1pt))
$

#[
  #set text(green)
  $
    markrect(x)
    + markrect(x, color: #red)
    + markrect(x, stroke: #1pt)
    + markrect(x, color: #red, stroke: #1pt)
    + markrect(x, stroke: #blue)
    + markrect(x, color: #red, stroke: #(blue + 1pt))
  $
]

$
  markrect(x, fill: #blue, stroke: #(green + 2pt))
  + markrect(x, color: #red, fill: #blue, stroke: #(dash: "dotted"))
$

$
  markrect(x, radius: #50%)
  + markrect(x, radius: #.1em, fill: #red)
$
