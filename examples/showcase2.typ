#import "/src/lib.typ": *
#import "@preview/cetz:0.5.2"

#set page(width: auto, height: auto, margin: (x: 4cm, top: 2cm, bottom: 1cm), fill: white)
#set text(24pt)

#let markhl = markhl.with(stroke: 1pt)

$
  markhl(1 mark(., #<sep>) 23, #<mantissa>, #red)
  mark(
    mark(times, #<prd>)
    mark(10, #<base>)^mark(4, #<exp>),
    #<pow>,
  )
$

#{
  let annot = annot.with(leader-tip: tiptoe.triangle, leader-toe: none)
  annot(<mantissa>, pos: left, dx: -.5em, dy: -1em, annot-text-props: (size: .9em))[mantissa]

  let annot = annot.with(leader-stroke: .03em, leader-tip: none, leader-toe: none)
  annot(<sep>, pos: bottom + left, dx: -.5em)[decimal \ separator]
  annot(<prd>, pos: top, dx: -1em, dy: -1.2em)[product]
  annot(<base>, pos: top, dy: -1em)[base]
  annot(<exp>, pos: top + right, dx: 1em)[exponent]

  annot-cetz(
    <pow>,
    cetz,
    {
      import cetz.draw: *
      cetz.decorations.flat-brace(
        "pow.south-west",
        "pow.south-east",
        flip: true,
        name: "brace",
        stroke: blue,
      )
      content("brace.south", anchor: "north", text(blue, .9em)[power])
    },
  )
}
