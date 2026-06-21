#import "/src/lib.typ": *
#import "/docs/doc-template.typ": example-grid

#set page(height: auto, margin: (x: .8cm, y: .5cm), fill: white)
#set text(14pt)


#example-grid(
  ```typst $ mark(x, #blue) $```,
  ```typst $ markhl(f(x), #purple, stroke: #1pt, radius: #10%) $```,
  ```typst $ markrect(e^x, #red, outset: #.2em) $```,
  ```typst $ markul(x + 1, #gray, stroke: #2pt) $```,
  ```typst $ markuw(x -> 0, #olive, amp: #.1em, wavelen: #.5em) $```,
  ```typst $ markub(lim sin x, #red, bracket: brace.b) $```,
)
