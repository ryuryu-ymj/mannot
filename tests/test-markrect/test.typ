#import "/src/mark.typ": markrect


$
  markrect(x)
$

$
  markrect(x, color: #red)
  + markrect(x, #red)
  + markrect(x, stroke: #1pt)
  + markrect(x, color: #red, stroke: #1pt)
  + markrect(x, color: #red, stroke: #blue)
  + markrect(x, color: #red, stroke: #(blue + 1pt))
$

#[
  #set text(green)
  $
    markrect(x)
    + markrect(x, color: #red)
    + markrect(x, stroke: #1pt)
    + markrect(x, color: #red, stroke: #1pt)
    + markrect(x, stroke: #blue)
    + markrect(x, color: #red, stroke: #(blue + 1pt))
  $
]

$
  markrect(x, fill: #blue, stroke: #(green + 2pt), tag: #<0>)
  + markrect(x, color: #red, fill: #blue, stroke: #(dash: "dotted"), outset: #2pt, tag: #<0>)
  + markrect(x, color: #green, stroke: #(left: 1pt), tag: #<0>)
  + markrect(x, color: #purple, stroke: #(y: (thickness: 2pt)), tag: #<0>)
$
#context {
  let queries = query(<0>)
  assert(queries.len() == 4)
  let size = measure($ x $)
  let data = queries.at(0).value
  assert(data.color == black)
  assert(calc.abs(size.width - data.mark-bounds.width) < 1e-9 * 1pt)
  assert(calc.abs((size.height + 0.1em * 2 - data.mark-bounds.height).to-absolute()) < 1e-9 * 1pt)
  assert(calc.abs(size.width + 2pt - data.annot-bounds.width) < 1e-9 * 1pt)
  assert(calc.abs((size.height + 0.1em * 2 + 2pt - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
  let data = queries.at(1).value
  assert(data.color == red)
  assert(calc.abs(size.width + 2pt * 2 - data.mark-bounds.width) < 1e-9 * 1pt)
  assert(calc.abs(size.height + 2pt * 2 - data.mark-bounds.height) < 1e-9 * 1pt)
  assert(calc.abs((size.width + 2pt * 2 + 0.048em - data.annot-bounds.width).to-absolute()) < 1e-9 * 1pt)
  assert(calc.abs((size.height + 2pt * 2 + 0.048em - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
  let data = queries.at(2).value
  assert(data.color == green)
  assert(calc.abs(size.width - data.mark-bounds.width) < 1e-9 * 1pt)
  assert(calc.abs((size.height + 0.1em * 2 - data.mark-bounds.height).to-absolute()) < 1e-9 * 1pt)
  assert(calc.abs(size.width + 0.5pt - data.annot-bounds.width) < 1e-9 * 1pt)
  assert(calc.abs((size.height + 0.1em * 2 - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
  let data = queries.at(3).value
  assert(data.color == purple)
  assert(calc.abs(size.width - data.mark-bounds.width) < 1e-9 * 1pt)
  assert(calc.abs((size.height + 0.1em * 2 - data.mark-bounds.height).to-absolute()) < 1e-9 * 1pt)
  assert(calc.abs(size.width - data.annot-bounds.width) < 1e-9 * 1pt)
  assert(calc.abs((size.height + 0.1em * 2 + 2pt - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
}

$
  markrect(x, radius: #50%)
  + markrect(x, radius: #.1em, fill: #red)
$
