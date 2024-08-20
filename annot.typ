#import "arrow.typ": place-path-arrow
#import "util.typ": copy-stroke


/// Annotate the marked content.
#let annot(tag, annotation, alignment: center + bottom, yshift: .6em, text-props: (size: .6em), arrow-stroke: .06em) = {
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
        let outer-tsize = text.size
        let text-args = text-props
        let annot-tsize = text-args.remove("size", default: outer-tsize)
        set text(size: annot-tsize)

        context {
            let mark = query(selector(tag).before(here())).last().value
            let hpos = here().position()

            let color = mark.color
            let arrow-stroke = arrow-stroke
            if arrow-stroke.paint == auto {
                arrow-stroke = copy-stroke(arrow-stroke, (paint: color))
            }
            let text-args = text-args
            if text-args.at("fill", default: auto) == auto {
                text-args.insert("fill", color)
            }

            let annot-content = text(..text-args, annotation)
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

            // Place the arrow.
            if alignment.x == center {
                place-path-arrow(stroke: arrow-stroke, tail-length: .3em, (p2x, p2y), (p3x, p3y))
            } else {
                place-path-arrow(stroke: arrow-stroke, tail-length: .3em, (p1x, p1y), (p2x, p2y), (p3x, p3y))
            }

            // Place the annotation.
            if alignment.x == right {
                place(annot-content, dx: p2x + annot-padding, dy: p2y - annot-size.height - annot-padding)
            } else if alignment.x == left {
                place(annot-content, dx: p2x - annot-size.width - annot-padding, dy: p2y - annot-size.height - annot-padding)
            } else {
                if alignment.y == bottom {
                    place(annot-content, dx: p2x - annot-size.width / 2, dy: p2y + annot-padding)
                } else {
                    place(annot-content, dx: p2x - annot-size.width / 2, dy: p2y - annot-size.height - annot-padding)
                }
            }

            // Add space above/below the marked content.
            if alignment.y == bottom {
                let spacing = (mark.padding.bottom + arrow-stroke.thickness
                        + yshift + annot-padding + annot-size.height)
                spacing = spacing.to-absolute()
                set text(size: outer-tsize)
                spacing -= .16em  // space of math.attach
                math.attach(
                    math.limits(hide(scale(x: 0%, reflow: true, $ mark.content $))),
                    // math.limits(mark.content),
                    // b: rect(width: 1pt, height: spacing),
                    b: v(spacing),
                )
            } else {
                let spacing = (mark.padding.top + arrow-stroke.thickness
                        + yshift + annot-padding + annot-size.height)
                spacing = spacing.to-absolute()
                set text(size: outer-tsize)
                spacing -= .16em  // space of math.attach
                math.attach(
                    math.limits(hide(scale(x: 0%, reflow: true, $ mark.content $))),
                    // math.limits(mark.content),
                    // t: rect(width: 1pt, height: spacing),
                    t: v(spacing),
                )
            }
        }
    }
}
