#import "/src/lib.typ": *

#set page(width: auto, height: auto, margin: (left: 4cm, top: 2cm, rest: 1cm), fill: white)
#set text(24pt)

$
  markul(p_i, #<p>)
  = markrect(
    exp(- mark(beta, #<beta>, #red) mark(E_i, #<E>, #green)),
    #<fac>, #blue,
  ) / markhl(sum_j exp(- beta E_j), #<Z>)
  //
  #annot(<p>, pos: bottom + left)[Probability of \ state $i$]
  #annot(<beta>, pos: top + left, dy: -1.5em, leader-connect: "elbow")[Inverse temperature]
  #annot(<E>, pos: top + right, dy: -1em)[Energy]
  #annot(<fac>, pos: top + left)[Boltzmann factor]
  #annot(<Z>)[Partition function]
$
