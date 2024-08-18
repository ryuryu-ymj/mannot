#import "util.typ": copy-stroke

#let place-path-arrow(
    stroke: 1pt,
    tail-length: 5pt,
    tail-angle: 30deg,
    ..vertices,
) = {
    place(path(stroke: stroke, ..vertices))

    let stroke = copy-stroke(stroke, (dash: "solid"))

    context {
        let vertices = vertices.pos()
        let tail-length = tail-length.to-absolute()

        let p1 = vertices.last()
        let p1x = p1.at(0).to-absolute()
        let p1y = p1.at(1).to-absolute()
        let p2 = vertices.at(vertices.len() - 2)
        let p2x = p2.at(0).to-absolute()
        let p2y = p2.at(1).to-absolute()

        let p12x = p2x - p1x
        let p12y = p2y - p1y
        let p12len = 1pt * calc.sqrt(p12x.pt() * p12x.pt() + p12y.pt() * p12y.pt())
        p12x = p12x / p12len * tail-length
        p12y = p12y / p12len * tail-length

        let angle = 30deg
        let sin = calc.sin(angle)
        let cos = calc.cos(angle)
        let t1x = p1x + p12x * cos - p12y * sin
        let t1y = p1y + p12x * sin + p12y * cos
        let t2x = p1x + p12x * cos + p12y * sin
        let t2y = p1y - p12x * sin + p12y * cos

        place(path(stroke: stroke, (t1x, t1y), (p1x, p1y), (t2x, t2y)))
    }
}

// #place-path-arrow(stroke: 1.4pt + orange, (0pt, 0pt), (0pt, 100pt), (100pt, 100pt))
