#import "/src/lib.typ": *

#set page(width: auto, height: auto, margin: (x: 2cm, y: 1cm), fill: white)
#set text(24pt)


$
  mark(x, #<1>, #green)
  + markhl(f(x), #<2>, #purple, stroke: #1pt, radius: #10%)
  + markrect(e^x, #<3>, #red, fill: #blue, outset: #.2em)
  + markul(x + 1, #<4>, #gray, stroke: #2pt)
  #annot(<1>)[Annotation]
  #annot(<3>, pos: top)[Another annotation]
$
