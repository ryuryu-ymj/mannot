#import "/src/mark.typ": markhl

#set text(48pt)

$
  markhl(x)
  markhl(x, color: #blue)
  markhl(x, stroke: #(1pt + red), fill: #green)
$

$
  markhl(x, radius: #.2em)
  markhl(x, radius: #100%, stroke: #(1pt + red))
$

$
  markhl(x, radius: #(top-left: 50%, right: .1em))
  + markhl(x, padding: #.2em)
  + markhl(x, padding: #(bottom: 5pt, rest: .5em))
$
