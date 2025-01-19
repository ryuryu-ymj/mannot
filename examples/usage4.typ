#import "/src/lib.typ": *

#set page(width: auto, height: auto, margin: (x: 4cm, y: 1cm), fill: white)
#set text(24pt)


#v(3em)
$
  mark(x, tag: #<t1>) + markrect(2y, tag: #<t2>)
  + markul(z+1, tag: #<t3>) + marktc(C, tag: #<t4>)

  #annot(<t1>, pos: left)[Set pos \ to left.]
  #annot(<t2>, pos: top, yshift: 1em)[Set pos to top, and yshift to 1em.]
  #annot(<t3>, pos: right, yshift: 1em)[Set pos to right,\ and yshift to 1em.]
  #annot(<t4>, pos: top + left, yshift: 3em)[Set pos to top+left,\ and yshift to 3em.]
$
#v(2em)
