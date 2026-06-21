#import "/src/lib.typ": *

#set page(width: auto, height: auto, margin: 1cm, fill: white)
#set text(24pt)

You need to insert spacing
#v(1em)  // <- Manual spacing.
$
  mark(x, #<1>, #green)
  #annot(<1>, pos: top + right)[Annotation]
  #annot(<1>, dy: 1em)[Annotation]
$
#v(2em)  // <- Manual spacing.
before/after the equations.
