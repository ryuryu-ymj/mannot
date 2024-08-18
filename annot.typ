#import "arrow.typ": place-path-arrow
#import "util.typ": copy-stroke

#let annot(tag, annotation, alignment: center + bottom, yshift: .6em, text-size: 0.6em, arrow-stroke: .06em) = {
    assert(
        alignment.x == left or alignment.x == center or
            alignment.x == right or alignment.x == none,
        message: "The field `x` of the argument `alignment` of the function
                `annot` must be `left`, `center`, `right` or `none`."
    )
    assert(
        alignment.y == top or alignment.y == bottom or
            alignment.y == none,
        message: "The field `y` of the argument `alignment` of the function
                `annot` must be `top`, `bottom` or `none`."
    )
    let alignment = (
        if alignment.x == none {
            center
        } else {
            alignment.x
        } + if alignment.y == none {
            bottom
        } else {
            alignment.y
        }
    )

    let arrow-stroke = stroke(arrow-stroke)
    if arrow-stroke.thickness == auto {
        arrow-stroke = copy-stroke(arrow-stroke, (thickness: .06em))
    }

    // Avoid spacing before `place`.
    h(0pt)

    context {
        let math-size = text.size
        set text(size: text-size)
        context {
            let mark = query(selector(tag).before(here())).last().value
            let hpos = here().position()

            let color = mark.color
            let arrow-stroke = arrow-stroke
            if arrow-stroke.paint == auto {
                arrow-stroke = copy-stroke(arrow-stroke, (paint: color))
            }

            let annot-content = text(fill: color, annotation)
            let annot-size = measure(annot-content)
            let annot-padding = 0.3em

            let p3x = (mark.x - mark.padding.left
                    + (mark.padding.left + mark.width + mark.padding.right) / 2
                    - hpos.x)
            let p3y = if alignment.y == bottom {
                mark.y + mark.height + mark.padding.bottom + arrow-stroke.thickness - hpos.y
            } else {
                mark.y - mark.padding.top - arrow-stroke.thickness - hpos.y
            }

            let p2x = p3x
            let p2y = if alignment.y == bottom {
                if alignment.x == center {
                    p3y + yshift
                } else {
                    p3y + annot-size.height + annot-padding * 2 + yshift
                }
            } else {
                p3y - yshift
            }

            let p1x = if alignment.x == right {
                p2x + annot-size.width + annot-padding
            } else if alignment.x == left {
                p2x - annot-size.width - annot-padding
            }
            let p1y = p2y

            if alignment.x == center {
                place-path-arrow(stroke: arrow-stroke, tail-length: .3em, (p2x, p2y), (p3x, p3y))
            } else {
                place-path-arrow(stroke: arrow-stroke, tail-length: .3em, (p1x, p1y), (p2x, p2y), (p3x, p3y))
            }

            if alignment.x == right {
                place(bottom + left, annot-content, dx: p2x + annot-padding, dy: p2y - annot-padding)
            } else if alignment.x == left {
                place(bottom + right, annot-content, dx: p2x - annot-padding, dy: p2y - annot-padding)
            } else {
                if alignment.y == bottom {
                    place(top + center, annot-content, dx: p2x, dy: p2y + annot-padding)
                } else {
                    place(bottom + center, annot-content, dx: p2x, dy: p2y - annot-padding)
                }
            }

            // Add space above/below the marked content.
            if alignment.y == bottom {
                let spacing = (mark.padding.bottom + arrow-stroke.thickness
                        + yshift + annot-padding + annot-size.height)
                spacing = spacing.to-absolute()
                set text(size: math-size)
                spacing -= .16em
                math.attach(
                    math.limits(hide(scale(x: 0%, reflow: true, $ mark.content $))),
                    // math.limits(scale(x: 10%, reflow: true, $ mark.content $)),
                    // b: rect(width: 1pt, height: spacing),
                    b: v(spacing),
                )
            } else {
                let spacing = (mark.padding.top + arrow-stroke.thickness
                        + yshift + annot-padding + annot-size.height)
                spacing = spacing.to-absolute()
                set text(size: math-size)
                spacing -= .16em
                math.attach(
                    math.limits(hide(scale(x: 0%, reflow: true, $ mark.content $))),
                    // t: rect(width: 1pt, height: spacing),
                    t: v(spacing),
                )
            }
        }
    }
}


#import "mark.typ": mark

$
2x + 3y = 4 \

mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(y, tag: #<y1>, color: #green)
= 4

#{
    annot(<c1>, alignment: top + left)[const.]
    annot(<c2>, alignment: top + center)[const.]
    annot(<x1>, yshift: 2em)[this is $x$]
    annot(<y1>, arrow-stroke: red)[this is $y$]
    annot(<y1>, arrow-stroke: (paint: blue, thickness: 4pt, cap: "round"))[this is $y$]
}

\

2x + 3y = 4
$
