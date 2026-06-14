#import "/src/mark.typ": markul, markuw

$
  underline(x + x)
  markuw(x + x, amp: #0pt)
  markuw(x + x + x + x)
$

$
  markuw(-1)
$

$
  markuw(x, color: #red)
  markuw(x, stroke: #1pt)
  markuw(x, color: #red, stroke: #1pt)
  markuw(x, color: #red, stroke: #blue)
  markuw(x, color: #red, stroke: #(blue + 1pt))
$

#[
  #set text(green)

  $
    markuw(x)
    markuw(x, color: #red)
    markuw(x, stroke: #1pt)
    markuw(x, color: #red, stroke: #1pt)
    markuw(x, color: #red, stroke: #blue)
    markuw(x, color: #red, stroke: #(blue + 1pt))
  $
]

$
  markuw(x + x, #<0>)
  markuw(x + x, #<0>, amp: #2pt, wavelen: #2pt, outset: #(x: 1pt, y: 2pt), stroke: #(1pt + red))
  #context {
    let queries = query(<0>)
    assert(queries.len() == 2)
    let size = measure($ x + x $)
    let hpos = here().position()
    let data = queries.at(0).value
    assert(data.color == black)
    assert(calc.abs(size.width - data.mark-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 0.244em - data.mark-bounds.height).to-absolute()) < 1e-9 * 1pt)
    assert(calc.abs(size.width - data.annot-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 0.244em + 0.04em * 2 + 0.048em / 2 - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
    place(dx: data.annot-bounds.x - hpos.x, dy: data.annot-bounds.y - hpos.y, rect(
      width: data.annot-bounds.width,
      height: data.annot-bounds.height,
      fill: red.transparentize(50%),
    ))
    let data = queries.at(1).value
    assert(data.color == black)
    assert(calc.abs(size.width + 2pt - data.mark-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 4pt - data.mark-bounds.height).to-absolute()) < 1e-9 * 1pt)
    assert(calc.abs(size.width + 2pt - data.annot-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 4pt + 2pt * 2 + 1pt / 2 - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
    place(dx: data.annot-bounds.x - hpos.x, dy: data.annot-bounds.y - hpos.y, rect(
      width: data.annot-bounds.width,
      height: data.annot-bounds.height,
      fill: red.transparentize(50%),
    ))
  }
$


$
  markuw(x, outset: #(bottom: .3em))
  + markuw(x, outset: #4pt)
$
