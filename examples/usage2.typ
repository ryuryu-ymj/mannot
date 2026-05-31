#import "/src/lib.typ": *

#set page(width: auto, height: auto, margin: (x: 2cm, y: .5cm), fill: white)
#set text(24pt)


$
  mark(x, #green)
  + markhl(f(x), #purple, stroke: #1pt, radius: #10%)
  + markrect(e^x, #red, fill: #blue, outset: #.2em)
  + markul(x + 1, #gray, stroke: #2pt)
$
