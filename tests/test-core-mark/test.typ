#import "/src/mark.typ": core-mark
// #import "@preview/mannot:0.3.2": core-mark


= API
== Underlay/overlay, color
$
  #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red)
  #core-mark($x$, overlay: (w, h, c) => rect(width: w, height: h, stroke: c), color: blue)
$

== Outset
$
  #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, mark-outset: none)
  + #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, mark-outset: .2em)
  + #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, mark-outset: (x: .1em, y: 4pt))
  + #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, mark-outset: (left: .1em, top: 4pt, rest: 8pt))
$

== Metadata
$
  #core-mark($x$, tag: <tag-test>, underlay: (w, h, c) => rect(width: w, height: h))
  quad
  #core-mark($y + 1$, tag: <tag-test>, color: red, mark-outset: (x: 1pt, y: .5pt), anchor-outset: (left: 2pt, top: 3pt, rest: 4pt), underlay: (w, h, c) => rect(width: w, height: h, fill: c))
$
#context {
  let queries = query(<tag-test>)
  assert(queries.len() == 2)
  let data = queries.first().value
  assert(data.body == $x$.body)
  assert(data.tag == <tag-test>)
  assert(data.color == black)
  let size = measure($ x $)
  assert(calc.abs(data.mark-bounds.width - size.width) < 1e-9 * 1pt)
  assert(calc.abs(data.mark-bounds.height - size.height) < 1e-9 * 1pt)
  assert(data.mark-bounds == data.anchor-bounds)
  let data = queries.at(1).value
  assert(data.body == $y + 1$.body)
  assert(data.tag == <tag-test>)
  assert(data.color == red)
  let size = measure($ y + 1 $)
  assert(calc.abs(data.mark-bounds.width - size.width - 2pt) < 1e-9 * 1pt)
  assert(calc.abs(data.mark-bounds.height - size.height - 1pt) < 1e-9 * 1pt)
  assert(calc.abs(data.anchor-bounds.width - size.width - 8pt) < 1e-9 * 1pt)
  assert(calc.abs(data.anchor-bounds.height - size.height - 8pt) < 1e-9 * 1pt)
}

= Debug
#{
  let mark = core-mark.with(debug: true)
  table(
    columns: 2,
    [inline], [block],
    $mark(x + y)$, $ mark(x + y) $,
  )
}

= Underlay/overlay size/position
#let debug = true
#table(
  columns: 3,
  [underlay], [overlay], [underlay & overlay],
  ..(
    // body => body,
    body => core-mark(
      body,
      debug: debug,
      underlay: (w, h, c) => {
        rect(width: w, height: h, stroke: 1pt + green)
      },
    ),
    body => core-mark(
      body,
      debug: debug,
      overlay: (w, h, c) => {
        rect(width: w, height: h, stroke: 1pt + blue)
      },
    ),
    body => core-mark(
      body,
      debug: debug,
      underlay: (w, h, c) => {
        rect(width: w, height: h, fill: green)
      },
      overlay: (w, h, c) => {
        rect(width: w, height: h, stroke: 1pt + blue)
      },
    ),
  ).map(mark => {
    $mark(x) mark(y) mark(T) mark(beta) mark(Pi)$

    $
      mark(x) mark(y) mark(T) mark(beta) mark(Pi)
    $

    $
      y / T
      mark(y) / mark(T)
      y_y / T^T
      mark(y_y) / mark(T^T)
    $

    $ mark(x + y)_mark(x + y)_mark(x + y) $
    $ mark(x + y)^mark(x + y)^mark(x + y) $

    $
      attach(limits(x), t: t, b: b, tr: t + r, br: b + r, tl: t + l, bl: b + l)
      attach(limits(mark(x)), t: mark(t), b: mark(b), tr: mark(t + r), br: mark(b + r), tl: mark(t + l), bl: mark(b + l))
    $

    $
      mark(integral x dif x)
      mark(integral) mark(x) mark(dif) mark(x)
    $

    $
      inline(mark(integral x dif x))
      script(mark(integral x dif x))
      sscript(mark(integral x dif x))
    $

    $ x y z $
    $ mark(x y z) $
    $ x mark(y) z $

    // Spacing
    $ x #h(1em)#h(2em) #[#h(1em)] y #[#h(1em)] #h(1em)#h(2em) z $
    $ mark(x) mark(#h(1em)#h(2em) #[#h(1em)] y #[#h(1em)] #h(1em)#h(2em)) mark(z) $
    let difx = $dif x$
    $ x mark(difx) $


    $
      -x \
      mark(-x)
    $

    $ x + y - z $
    $ mark(x + y - z) $
    $ x + mark(y) - z $
    $ mark(x) + mark(y) - mark(z) $
    $ x mark(+) y mark(-) z $
    $ mark(x) mark(+) mark(y) mark(-) mark(z) $
    $ mark(x +) mark(y) mark(- z) $

    // Align
    $
      mark(x &+ 2y &+ 3z &= 4) \
                       mark(x) & + mark(2y &&=) 4 \
                mark(x &&+ 3z) & = mark(4) \
    $

    $
      3!
      mark(3!)
      mark(3)!
      3mark(!)
    $

    // nested
    $
      mark(mark(x) + mark(y)) +
      mark(mark(mark(x) + mark(y)) + mark(z))
    $

    $
      x mark(mark(+) y) mark(mark(+))
      mark(x mark(+)) y
    $

    // Issue10
    $
      mark(mark(y) / T)
      + mark(T / mark(y))
      + mark((1 + mark(y)) / mark(T))
    $

    $
      mark(mark(x)^T)
      + mark(x^mark(T))
      + mark(mark(x)_q)
      + mark(x_mark(q))
    $
  }),
)


== Different fonts
#let mark(body) = core-mark(
  body,
  underlay: (w, h, c) => {
    rect(width: w, height: h, stroke: 1pt + green)
  },
)

#{
  for size in (4pt, 8pt, 16pt) {
    show math.equation: set text(size)
    list(repr(size))
    $
      mark(x) mark(y) mark(T) mark(integral x dif x)
    $
  }
}

#{
  for font in ("New Computer Modern Math", "STIX Two Math", "Libertinus Math") {
    show math.equation: set text(font: font)
    list(font)
    $
      mark(x) mark(y) mark(T) mark(integral x dif x)
    $
  }
}

== RTL
#{
  set text(dir: rtl)
  [This is RTL text.]

  $
    mark(x) mark(y) mark(T) mark(integral x dif x)
  $
}
