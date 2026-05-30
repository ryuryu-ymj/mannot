#import "/src/mark.typ": mark

$
  mark(x)
  mark(x, color: #green)
$

#[
  #set text(red)
  $
    mark(x, tag: #<0>)
  $

  #context {
    query(<0>)
  }
]

// test-args
$
  mark(x, #green)
  mark(x, #<tag>)
  mark(x, #<tag>, #blue)
  mark(x, #blue, #<tag>)
  #context { assert(query(<tag>).len() == 3) }
$
#assert-panic(() => $mark(x, <0>)$)
#assert-panic(() => $mark(#red, x)$)
#assert-panic(() => $mark(x, colour: #red)$)
