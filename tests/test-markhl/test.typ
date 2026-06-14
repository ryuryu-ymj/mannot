#import "/src/mark.typ": markhl

$
  markhl(x)
$

$
  markhl(x, color: #blue)
  + markhl(x, #blue)
  + markhl(x, color: #blue, stroke: #1pt)
  + markhl(x, color: #blue, stroke: #red)
  + markhl(x, color: #blue, stroke: #(1pt + red))
$

$
  markhl(x, #red, #<0>)
  + markhl(x, fill: #red, tag: #<0>)
  + markhl(x, fill: #red, stroke: #1pt, tag: #<0>)
  + markhl(x, color: #green, fill: #red, tag: #<0>)
  #[
    #set text(blue)
    $ + markhl(x, fill: #red, tag: #<0>) $
  ]
$
#context {
  let colors = query(<0>).map(q => q.value.color)
  assert(colors == (red, black, black, green, blue))
}

$
  markhl(x, radius: #.2em)
  + markhl(x, radius: #100%, stroke: #1pt)
  + markhl(x, radius: #(top-left: 50%, right: .1em))
$

$
  markhl(x, outset: #.2em)
  + markhl(x, outset: #(bottom: 5pt, rest: .5em))
$
