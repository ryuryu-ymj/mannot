#import "/src/mark.typ": markhl

$
  markhl(x)
$

$
  markhl(x, color: #blue)
  markhl(x, stroke: #(1pt + red), fill: #green)
$

$
  markhl(x, fill: #red, tag: #<0>)
$
#[
  #set text(blue)
  $
    markhl(x, fill: #red, tag: #<0>)
  $
]
#context {
  query(<0>)
}

$
  markhl(x, radius: #.2em)
  markhl(x, radius: #100%, stroke: #(1pt + red))
$

$
  markhl(x, radius: #(top-left: 50%, right: .1em))
  + markhl(x, outset: #.2em)
  + markhl(x, outset: #(bottom: 5pt, rest: .5em))
$
