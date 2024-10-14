#import "/src/lib.typ": *

#let entrypoint = toml("/typst.toml").package.entrypoint
#let usage = "#import \"/" + entrypoint + "\": *\n" + "#show: mannot-init\n"

#let example(source) = {
  grid(
    columns: (1fr, 2fr),
    rows: (auto),
    align: center + horizon,
    gutter: 8pt,
    rect(
      width: 100%,
      inset: 10pt,
      {
        eval(usage + source, mode: "markup")
      },
    ),
    raw(block: true, lang: "typst", source),
  )
}
