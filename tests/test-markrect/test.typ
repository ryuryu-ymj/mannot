#import "/src/mark.typ": markrect


$
  markrect(x)
$

$
  markrect(x, color: #red)
$

$
  markrect(x, fill: #blue, stroke: #(green + 2pt))
  + markrect(x, color: #red, fill: #blue, stroke: #(dash: "dotted"))
$

$
  markrect(x, radius: #50%)
  + markrect(x, radius: #.1em, fill: #red)
$
