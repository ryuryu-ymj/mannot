#import "arrow.typ": place-path-arrow

#let annot(tag, annotation, alignment: center + bottom, yshift: .6em, arrow-stroke: .06em) = {
    assert(
        alignment.x == left or alignment.x == center or alignment.x == right,
        message: "The field `x` of the argument `alignment` of the function
                `annot` must be `left`, `center` or `right`."
    )
    assert(
        alignment.y == top or alignment.y == bottom,
        message: "The field `y` of the argument `alignment` of the function
                `annot` must be `top` or `bottom`."
    )
    let arrow-stroke = stroke(arrow-stroke)
    if arrow-stroke.thickness == auto {
        arrow-stroke = stroke((
            paint: arrow-stroke.paint,
            thickness: .06em,
            cap: arrow-stroke.cap,
            join: arrow-stroke.join,
            dash: arrow-stroke.dash,
            miter-limit: arrow-stroke.miter-limit,
        ))
    }

    set text(size: 0.6em)

    context {
        let mark = query(selector(tag).before(here())).last().value
        let hpos = here().position()

        let color = mark.color
        let arrow-stroke = arrow-stroke
        if arrow-stroke.paint == auto {
            arrow-stroke = stroke((
                paint: color,
                thickness: arrow-stroke.thickness,
                cap: arrow-stroke.cap,
                join: arrow-stroke.join,
                dash: arrow-stroke.dash,
                miter-limit: arrow-stroke.miter-limit,
            ))
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
        } else {
            p2x
        }
        let p1y = p2y

        if alignment.y == bottom {
            let vs = .2em + yshift + annot-padding + annot-size.height
            let vs = vs.to-absolute()
            $ limits(#none)_#v(vs) $
            // place($ limits(#none)_#rect(width: p2x * 2, height: vs) $)
            // place(rect(width: p2x, height: vs) )
        } else {
            let vs = .8em + yshift + annot-padding + annot-size.height
            let vs = vs.to-absolute()
            $ limits(#none)^#v(vs) $
            // $ limits(#none)^#rect(width: 4pt, height: vs) $
            // place(dx: p3x, bottom, $ limits(#none)^#rect(width: 4pt, height: vs) $)
        }

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
