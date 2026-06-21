#import "/src/lib.typ": *

#let entrypoint = toml("/typst.toml").package.entrypoint
#let usage = "#import \"/" + entrypoint + "\": *\n"

#let example-vstack(source) = {
  eval(usage + source.text, mode: "markup")
  {
    set text(0.9em)
    source
  }
}

#let example-grid(..source) = {
  let pairs = source
    .pos()
    .map(s => (
      {
        set text(0.9em)
        s
      },
      box(
        inset: .2em,
        width: 100%,
        eval(usage + s.text, mode: "markup"),
      ),
    ))
    .flatten()
  rect(
    radius: .3em,
    stroke: .3pt + gray,
    inset: .6em,
    grid(
      columns: (1fr, .5fr),
      row-gutter: .8em,
      column-gutter: 1em,
      align: horizon,
      ..pairs,
    ),
  )
}
