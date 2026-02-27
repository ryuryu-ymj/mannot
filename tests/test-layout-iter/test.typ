#import "/src/lib.typ": *
#import "@preview/layout-ltd:0.1.0": layout-limiter
#import "@preview/cetz:0.4.2"

// This causes layout unconvergence.
// #show: layout-limiter.with(max-iterations: 2)

#show: layout-limiter.with(max-iterations: 3)

$
  markhl(x)
  markul(y)
  markrect(z)
$

$
  markhl(markhl(x) + markhl(markhl(y) + z))
$

$
  markhl(x, tag: #<t>)
  #annot(<t>)[Annotation.]
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
