#import "/src/lib.typ": *

#set page(width: auto, height: auto, margin: (x: 2cm, y: 1cm), fill: white)
#set text(24pt)


$
  mark(x, tag: #<t1>) + markrect(2y, tag: #<t2>)
  + markul(z+1, tag: #<t3>) + marktc(C, tag: #<t4>)

  #annot(<t1>)[annotation]
  #annot(<t4>)[another annotation]
$
