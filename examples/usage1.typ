#import "/src/lib.typ": *
#import "/docs/doc-template.typ": example-grid

#set page(height: auto, margin: (x: .8cm, y: .5cm), fill: white)
#set text(16pt)


#columns(
  2,
  {
    example-grid(
      ```typst $ mark(x + y, #red) $```,
      ```typst $ markhl(x + y) $```,
      ```typst $ markrect(x + y) $```,
    )
    colbreak()
    example-grid(
      ```typst $ markul(x + y) $```,
      ```typst $ markuw(x + y) $```,
      ```typst $ markub(x + y) $```,
    )
  },
)
