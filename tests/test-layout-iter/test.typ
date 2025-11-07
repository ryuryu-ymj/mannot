#import "/src/lib.typ": *
#import "@preview/layout-ltd:0.1.0": layout-limiter

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
