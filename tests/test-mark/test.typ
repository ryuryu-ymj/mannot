#import "/src/mark.typ": mark

$
  mark(x)
  mark(x, color: #green)
  x
  #{
    set text(red)
    $ mark(x) mark(x, color: #green) x $
  }
  x
$

#[
  #set text(red)
  $
    mark(x, tag: #<0>)
  $

  #context {
    let data = query(<0>)
    assert(data.len() == 1)
    let data = data.first().value
    assert(data.body == $x$.body)
    assert(data.color == red)
  }
]

$
  mark(x, #blue) mark(+ 1, #purple)
$

// test-args
$
  mark(x, #green)
  mark(x, #<tag>)
  mark(x, #<tag>, #blue)
  mark(x, #blue, #<tag>)
  mark(beta, #gray)
  mark("x", #olive)
  mark(#red, x)
  mark(#<tag>, x, #red)
  mark(#<tag>, #red, x)
  #context { assert(query(<tag>).len() == 5) }
$
#assert-panic(() => $mark(x, x)$)
#assert-panic(() => $mark(#red)$)
#assert-panic(() => $mark(#<0>, #red)$)
#assert-panic(() => $mark(x, <0>)$)
#assert-panic(() => $mark(x, colour: #red)$)
