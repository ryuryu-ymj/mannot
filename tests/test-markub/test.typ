#import "/src/mark.typ": markub
// #show math.equation: set text(font: "STIX Two Math")
// #show math.equation: set text(font: "Libertinus Math")

$
  underbracket(x)
  + underbracket(x + y)
  underbracket(- integral x dif x)
  quad
  markub(x)
  + markub(x + y)
  markub(- integral x dif x)
$

$
  markub(x + y, #red)
  + markub(x + y, #blue, bracket: brace.b)
$

#for b in (sym.bracket.b, sym.brace.b, sym.paren.b, sym.shell.b) {
  $
    #range(0, 10).map(w => $markub(#rect(width: w * .4em, height: 1em), bracket: #b, tag: #<0>)$).join($+$)
  $
}
$
  #context {
    let hpos = here().position()
    for q in query(<0>) {
      let data = q.value
      place(dx: data.anchor-bounds.x - hpos.x, dy: data.anchor-bounds.y - hpos.y, rect(
        width: data.anchor-bounds.width,
        height: data.anchor-bounds.height,
        fill: red.transparentize(50%),
      ))
    }
  }
$

#box(
  fill: red.transparentize(50%),
  width: 4em,
  $
    markub(x + y)
  $,
)
#box(
  fill: red.transparentize(50%),
  width: 2em,
  $
    markub(x + y)
  $,
)
