# Mannot
A package to highlight and annotate parts of math block in [Typst](https://typst.app/).

## Examples
```typst
$
mark(1, tag: #<num>) / mark(x + 1, tag: #<den>, color: #blue)
+ mark(2, tag: #<quo>, color: #red)

#annot(<num>, pos: top)[Numerator]
#annot(<den>)[Denominator]
#annot(<quo>, pos: right, yshift: 1em)[Quotient]
$
```

![Example1](/examples/showcase.svg)

## Usage
Import and initialize the package `mannot` on the top of your document.
```typst
#import "@preview/mannot:0.1.0": *
#show: mannot-init
```

To highlight a part of a math block, use the `mark` function:
```typst
$
mark(x)
$
```
