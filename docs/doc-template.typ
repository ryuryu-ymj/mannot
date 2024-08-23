#import "/src/lib.typ": *

#let entrypoint = toml("/typst.toml").package.entrypoint
#let import-statement = "#import \"/" + entrypoint + "\": *\n"

#let example(source) = {
  grid(
    columns: (1fr, 2fr),
    rows: (auto),
    align: center + horizon,
    gutter: 8pt,
    rect(width: 100%, inset: 8pt, {
      eval(import-statement + source, mode: "markup")
    }),
    raw(block: true, lang: "typst", source),
  )
}
