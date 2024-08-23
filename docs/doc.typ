#import "@preview/tidy:0.3.0"
#import "@preview/codly:1.0.0": *
#import "/src/lib.typ": *
#import "doc-template.typ": *

#show link: underline

#show raw: set text(7pt)
#show: codly-init.with()
#codly(lang-format: none)

#let package-info = toml("/typst.toml")
#let name = package-info.package.name
#let version = package-info.package.version

#{name + " v" + version}

= Usage

#let import-statement = "#import \"@preview/" + name + ":" + version + "\": *"
#raw(block: true, lang: "typst", import-statement)

= Examples

#example("$
mark(x)
$")

#example("$
mark(3, color: #red)mark(x, color: #blue)
+ mark(integral x dif x, color: #green)
$")

#example("$
mark(x, tag: #<x>)
#annot(<x>)[Annotation]
$")

#example("#let rmark = mark.with(color: red)
#let gmark = mark.with(color: green)
#let bmark = mark.with(color: blue)

$
integral_rmark(0, tag: #<i0>)^bmark(1, tag: #<i1>)
mark(x^2 + 1, tag: #<i2>) dif\"\"gmark(x, tag: #<i3>)

#{
  annot(<i0>)[Start]
  annot(<i1>, alignment: top)[End]
  annot(<i2>, alignment: top + right)[Integrand]
  annot(<i3>, alignment: right)[Variable]
}
$")


= API
#let docs = (
  tidy.parse-module(read("/src/mark.typ") + read("/src/annot.typ"))
)
#tidy.show-module(docs, show-outline: true, sort-functions: none)
