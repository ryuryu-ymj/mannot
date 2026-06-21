#import "/src/lib.typ": *

#set page(width: auto, height: auto, margin: (x: 2cm, top: 2cm, bottom: 1cm), fill: white)
#set text(24pt)


$
  mark(x, #<tag>) + markhl(f(x), #<0>)
  //
  #annot(<tag>)[Annotation]
  #annot(<0>, pos: top, dy: -1em)[Another Annotation]
$
