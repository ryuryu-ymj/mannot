#import "/src/mark.typ": mark
#import "/src/annot.typ": annot-cetz
#import "@preview/cetz:0.4.2"

$
  mark(integral x dif x, tag: #<0>)
  #annot-cetz(<0>, cetz, {
    import cetz.draw: *

    rect((0, 0), (-.5, .5))
    circle("0", radius: .02, fill: red, stroke: none)
    rect("0.north-west", "0.south-east", stroke: red)
  })
$

#v(2em)
$
  mark(integral x dif x, tag: #<0>)
  + mark(x + 3, tag: #<1>) / 2
  #annot-cetz((<0>, <1>), cetz, {
    import cetz.draw: *

    rect((0, 0), (-.5, .5))
    line("0", "1", stroke: blue)
    rect("0.north-west", "0.south-east", stroke: red)
    circle("0", radius: .02, fill: red, stroke: none)
    rect("1.north-west", "1.south-east", stroke: red)
    circle("1", radius: .02, fill: red, stroke: none)
  })
$


#v(2em)
$
  mark(x, tag: #<0>)
  + mark(y, tag: #<1>)
  #annot-cetz((<0>, <1>), cetz, {
    import cetz.draw: *

    content((1, -.6), [Annotation], anchor: "north", name: "a")
    set-style(stroke: .7pt, mark: (start: "straight", scale: 0.6))
    line("0", "a")
    line("1", "a")

    content((-.2, .6), [Annotation], anchor: "north", name: "a")
    set-style(stroke: .7pt, mark: (start: "straight", scale: 0.6))
    line("0", "a")
    line("1", "a")
  })
$
