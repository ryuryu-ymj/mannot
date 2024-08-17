#import "arrow.typ": place-path-arrow

#let annot(tag, annotation, yshift: 0em) = {
    set text(size: 0.6em)

    context {
        let mark = query(selector(tag).before(here())).first().value

        let hpos = here().position()
        let p3x = mark.x - mark.padding.left + mark.width / 2 - hpos.x
        let p3y = mark.y + mark.height + mark.padding.bottom - hpos.y

        let color = mark.color
        let annot-content = text(fill: color, annotation)
        let annot-size = measure(annot-content)
        let annot-padding = 0.3em.to-absolute()

        let yshift = yshift.to-absolute()
        let p2x = p3x
        let p2y = p3y + annot-size.height + 1em + annot-padding + yshift

        let p1x = p2x + annot-size.width + annot-padding
        let p1y = p2y

        $ limits(#none)^#v(0em)_#v(p2y - p3y) $
        place-path-arrow(stroke: .06em + color, tail-length: .3em, (p1x, p1y), (p2x, p2y), (p3x, p3y + .3em))
        place(bottom + left, annot-content, dx: p2x + annot-padding, dy: p2y - annot-padding)
    }
}


#import "mark.typ": mark

$
mark(2, tag: #<c1>)mark(x, tag: #<x1>, color: #blue)
+ mark(3, tag: #<c2>)mark(y, tag: #<y1>, color: #green)
= 4

#{
    annot(<x1>, yshift: 1em)[annotation]
    annot(<c1>)[annotation]
}

\

2x + 3y = 4
$
