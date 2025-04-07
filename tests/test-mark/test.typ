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
