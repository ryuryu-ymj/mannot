#import "/src/mark.typ": markhl, markrect
#import "/src/annot.typ": annot, tiptoe

// #import "@preview/tiptoe:0.3.0"


#{
  let lab(body) = rect(stroke: silver, body)
  let annot = annot.with(annot-inset: 0pt)

  grid(
    columns: 3,
    inset: (bottom: 4em),
    gutter: (8em, 16em),
    $
      markrect(integral x dif x, tag: #<1>, color: #red)
      #annot(<1>, pos: top, lab[top])
      #annot(<1>, pos: left, lab[left])
      #annot(<1>, pos: bottom, lab[bottom])
      #annot(<1>, pos: right, lab[right])
    $,
    $
      markrect(integral x dif x, tag: #<1>, color: #red)
      #annot(<1>, pos: top + left, lab[top + left])
      #annot(<1>, pos: top + right, lab[top + right])
      #annot(<1>, pos: bottom + left, lab[bottom + left])
      #annot(<1>, pos: bottom + right, lab[bottom + right])
    $,
    $
      markrect(integral x dif x, tag: #<1>, color: #red)
      #annot(<1>, pos: (top + left, bottom + right), lab[(top + left, bottom + right)])
      #annot(<1>, pos: (top + left, top + right), lab[(top + left, top + right)])
      #annot(<1>, pos: (top + left, bottom + left), lab[(top + left, bottom + left)])
      #annot(<1>, pos: (top + left, top + left), lab[(top + left, top + left)])
    $,
  )
}

$
  markhl(integral x dif x, tag: #<0>)
  #h(6em)
  markhl(integral x dif x, tag: #<1>)
  #annot(<0>, dx: 1em, dy: 1em)[b]
  #annot(<0>, dx: -1em, dy: 1em, pos: left)[l]
  #annot(<0>, dx: 1em, dy: 1em, pos: right)[r]
  #annot(<0>, dx: 1em, dy: -1em, pos: top)[t]
  #annot(<0>, dx: -1em, dy: -1em, pos: top + left)[tl]
  #annot(<0>, dx: 2em, dy: -1em, pos: top + right)[tr]
  #annot(<0>, dx: -1em, dy: 1em, pos: bottom + left)[bl]
  #annot(<0>, dx: 2em, dy: 1em, pos: bottom + right)[br]
  #{
    let annot = annot.with(leader-connect: "elbow")
    annot(<1>)[b]
    annot(<1>, dx: 1em, dy: 1em)[b]
    annot(<1>, dx: -1em, dy: 2em, pos: left)[l]
    annot(<1>, dx: -1em, dy: 0em, pos: left)[l]
    annot(<1>, dx: 1em, dy: -1em, pos: right)[r]
    annot(<1>, dx: 1em, dy: -2em, pos: right)[r]
    annot(<1>, dx: 1em, dy: -1em, pos: top)[t]
    annot(<1>, dx: -1em, dy: -1em, pos: top + left)[tl]
    annot(<1>, dx: 2em, dy: -1em, pos: top + right)[tr]
    annot(<1>, dx: -3em, dy: 1em, pos: bottom + left)[bl]
    annot(<1>, dx: 2em, dy: 1em, pos: bottom + right)[brgg]

    annot(<1>, dy: 2em)[#lorem(4)]
    annot(<1>, dx: 1em, dy: -2em, pos: top)[#lorem(4)]
  }
$
#v(2em)

$
  markhl(integral x dif x, tag: #<0>)
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (left, center + horizon))[$ integral x dif x $]
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (right, center + horizon))[$ integral x dif x $]
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (top, center + horizon))[$ integral x dif x $]
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (bottom, center + horizon))[$ integral x dif x $]
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (left + top, center + horizon))[$ integral x dif x $]
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (left + bottom, center + horizon))[$ integral x dif x $]
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (right + top, center + horizon))[$ integral x dif x $]
  #annot(<0>, pos: left, dx: -1em, dy: 1.5em, leader-connect: (right + bottom, center + horizon))[$ integral x dif x $]
  -
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, left))[$ integral x dif x $]
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, right))[$ integral x dif x $]
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, top))[$ integral x dif x $]
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, bottom))[$ integral x dif x $]
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, left + top))[$ integral x dif x $]
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, left + bottom))[$ integral x dif x $]
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, right + top))[$ integral x dif x $]
  #annot(<0>, pos: right, dx: 1em, dy: 1.5em, leader-connect: (center + horizon, right + bottom))[$ integral x dif x $]
$
#v(2em)

$
  markhl(integral x dif x, tag: #<0>)
  #annot(<0>, pos: bottom)[a]
  #annot(<0>, pos: bottom, dx: 1em)[a]
  #annot(<0>, pos: bottom, dx: 2.1em)[a]
  #annot(<0>, pos: bottom, dx: 2.2em, leader-stroke: blue, text(blue)[a])
  #annot(<0>, pos: bottom, dx: 2.1em, dy: .4em, leader-stroke: blue, text(green)[a])
  #annot(<0>, pos: bottom, dx: -1em, dy: .4em, leader-stroke: blue, text(green)[a])
$
#v(2em)


$
  markhl(x, tag: #<0>)
  + markhl(y, tag: #<1>, color: #blue)
  + markhl(z, tag: #<2>, color: #green)
  #annot((<0>, <1>), pos: bottom + right, dy: .5em)[TTT]
  #annot((<1>, <0>, <2>), pos: top, dy: -.5em)[TTT]
$
#v(2em)

$
  markhl(x, tag: #<0>)
  + markhl(y, tag: #<1>, color: #blue)
  + markhl(z, tag: #<2>, color: #green)
  #{
    let annot = annot.with(leader-connect: "elbow")
    annot((<0>, <1>), pos: bottom + right, dy: .5em)[TTT]
    annot((<1>, <0>, <2>), pos: top, dy: -.5em)[TTT]
  }
$
#v(2em)

$
  markhl(#rect(), tag: #<0>)
  #h(3em)
  markhl(#rect(), tag: #<1>)
  // #annot(<0>)[b \ bbb]
  #annot(<0>)[ggg \ TTT]
  #annot(<0>, pos: left)[l \ lll]
  #annot(<0>, pos: right)[r \ rrr]
  #annot(<0>, pos: top)[t \ ttt]
  #annot(<1>, pos: top + left)[tl \ tltltl]
  #annot(<1>, pos: top + right)[tr \ trtrtr]
  #annot(<1>, pos: bottom + left)[bl \ blblbl]
  #annot(<1>, pos: bottom + right)[br \ brbrbr]
$
#v(3em)

#[
  #set text(dir: rtl)
  $
    markhl(#rect(), tag: #<0>)
    #h(3em)
    markhl(#rect(), tag: #<1>)
    // #annot(<0>)[b \ bbb]
    #annot(<0>)[ggg \ TTT]
    #annot(<0>, pos: left)[l \ lll]
    #annot(<0>, pos: right)[r \ rrr]
    #annot(<0>, pos: top)[t \ ttt]
    #annot(<1>, pos: top + left)[tl \ tltltl]
    #annot(<1>, pos: top + right)[tr \ trtrtr]
    #annot(<1>, pos: bottom + left)[bl \ blblbl]
    #annot(<1>, pos: bottom + right)[br \ brbrbr]
  $
  #v(3em)
]

$
  markhl(x, tag: #<0>)
  #annot(<0>, pos: top, dy: -1em, leader-stroke: 2pt + green, leader-tip: tiptoe.bar, leader-toe: tiptoe.circle.with(align: end))[a]
  #annot(<0>, pos: right, annot-text-props: (size: 1em, fill: blue, font: "Dejavu Sans Mono"), annot-alignment: right, annot-par-props: (leading: 0pt))[aaaa \ bb]
  #annot(<0>, pos: left, dx: -1em, annot-inset: 1em)[aaa]
  #annot(<0>, pos: bottom + left, dy: 1em, leader-connect: "elbow", annot-inset: (left: 1em, right: .5em, y: .8em))[aaa]
$
