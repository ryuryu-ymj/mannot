#import "/src/mark.typ": core-mark


= API
== Underlay/overlay, color
$
  #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red)
  #core-mark($x$, overlay: (w, h, c) => rect(width: w, height: h, stroke: c), color: blue)
$

== Outset
$
  #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, outset: none)
  + #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, outset: .2em)
  + #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, outset: (x: .1em, y: 4pt))
  + #core-mark($x$, underlay: (w, h, c) => rect(width: w, height: h, fill: c), color: red, outset: (left: .1em, top: 4pt, rest: 8pt))
$

== Tag
$
  #core-mark($x$, tag: <tag1>, underlay: (w, h, c) => rect(width: w, height: h))

  #core-mark($x$, tag: <tag1>, color: red, outset: 1pt, underlay: (w, h, c) => rect(width: w, height: h, fill: c))
$
#context {
  query(<tag1>)
}


= Underlay/overlay size/position
#for mark in (
  body => core-mark(
    body,
    underlay: (w, h, c) => {
      rect(width: w, height: h, stroke: 1pt + green)
    },
  ),
  body => core-mark(
    body,
    overlay: (w, h, c) => {
      rect(width: w, height: h, stroke: 1pt + blue)
    },
  ),
  body => core-mark(
    body,
    underlay: (w, h, c) => {
      rect(width: w, height: h, fill: green)
    },
    overlay: (w, h, c) => {
      rect(width: w, height: h, stroke: 1pt + blue)
    },
  ),
) {
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
    mark(x) &+ mark(2y &&=) 4 \
    mark(x &&+ 3z) &= mark(4) \
  $

  $
    3!
    mark(3!)
    mark(3)!
    3mark(!)
  $
}


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
  for font in ("New Computer Modern Math", "STIX Two Math", "DejaVu Math TeX Gyre", "Libertinus Math") {
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
