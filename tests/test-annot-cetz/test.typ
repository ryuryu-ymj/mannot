#import "/src/mark.typ": mark
#import "/src/annot.typ": annot-cetz
#import "@preview/cetz:0.4.2"

$
  mark(x, tag: #<0>)
  #annot-cetz(<0>, cetz, {
    import cetz.draw: *

    rect("0.north-west", "0.south-east")
  })
$

$
  mark(x, tag: #<0>)
  + mark(y, tag: #<1>)
  #annot-cetz((<0>, <1>), cetz, {
    import cetz.draw: *

    content((1, -.6), [Annotation], anchor: "north", name: "a")
    set-style(stroke: .7pt, mark: (start: "straight", scale: 0.6))
    line("0", "a")
    line("1", "a")
  })
$
