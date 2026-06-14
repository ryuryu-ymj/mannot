#import "/src/mark.typ": markul

$
  underline(x)
  markul(x)
  underline(y)
  markul(y)
$

$
  markul(x, color: #red)
  markul(x, #red)
  markul(x, stroke: #1pt)
  markul(x, color: #red, stroke: #1pt)
  markul(x, color: #red, stroke: #blue)
  markul(x, color: #red, stroke: #(blue + 1pt))
$

#[
  #set text(green)

  $
    underline(x)
    markul(x)
    markul(x, color: #red)
    markul(x, stroke: #1pt)
    markul(x, color: #red, stroke: #1pt)
    markul(x, color: #red, stroke: #blue)
    markul(x, color: #red, stroke: #(blue + 1pt))
  $
]

$
  markul(x, stroke: #(1pt + blue))
  markul(x, stroke: #(paint: green, dash: "dotted"))
$

$
  markul(x, outset: #(bottom: .3em))
  + markul(x, outset: #.3em)
$

$
  markul(x, #<0>)
  + markul(x, #<0>, #red, stroke: #2pt, outset: #(right: 2pt, y: 4pt))
  #context {
    let queries = query(<0>)
    assert(queries.len() == 2)
    let size = measure($ x $)
    let data = queries.at(0).value
    assert(data.color == black)
    assert(calc.abs(size.width - data.mark-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 0.244em - data.mark-bounds.height).to-absolute()) < 1e-9 * 1pt)
    assert(calc.abs(size.width - data.annot-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 0.244em + 0.048em / 2 - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
    let data = queries.at(1).value
    assert(data.color == red)
    assert(calc.abs(size.width + 2pt - data.mark-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 4pt * 2 - data.mark-bounds.height).to-absolute()) < 1e-9 * 1pt)
    assert(calc.abs(size.width + 2pt - data.annot-bounds.width) < 1e-9 * 1pt)
    assert(calc.abs((size.height + 4pt * 2 + 1pt - data.annot-bounds.height).to-absolute()) < 1e-9 * 1pt)
  }
$
