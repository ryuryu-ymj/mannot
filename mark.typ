#let _mark-cnt = counter("_mark")

#let _sequence-func = (math.text("x") + math.text("y")).func()

#let _label-each-child(content, label) = {
    if content.func() == _sequence-func {
        // If `content` is the sequence of contents,
        // then put `lable` on each child.
        let children = content.children
            .filter((c) => c != [ ])
            .map((c) => {
                _label-each-child(c, label)
            })
        return content.func()(children)
    } else if content.fields() == (:) {
        // Do not put `label` on no-field `content` such as align-point().
        return content
    } else {
        return [#content#label]
    }
}


/// Define the target of annotation within some math block.
#let mark(content, tag: none, color: auto, fill: auto, stroke: (:), radius: (:), padding: (y: 0.1em), scriptlevel: 0) = {
    if fill == auto {
        if color == auto {
            color = orange
        }
        if color.components().len() > 2 {
            // Create a pastel color.
            let lch = oklch(color)
            fill = lch.lighten(40%).desaturate(50%)
        } else {
            // If color is grayscale, then fill lightgray.
            fill = luma(80%)
        }
    } else if color == auto {
        color = black
    }

    // Place a highlight rect behind the `content`.
    context{
        let cnt-get = _mark-cnt.get().first()
        let info-lab = if tag == none {
            label("_mark-info-" + str(cnt-get))
        } else {
            tag
        }

        let info = query(selector(info-lab).after(here())).first().value
        let hpos = here().position()
        let dx = info.x - info.padding.left - hpos.x
        let dy = info.y - info.padding.top - hpos.y
        let width = info.width + info.padding.left + info.padding.right
        let height = info.height + info.padding.top + info.padding.bottom
        place(dx: dx, dy: dy, rect(width: width, height: height, fill: fill, stroke: stroke, radius: radius))
    }

    // Produce labeled `content`, measure its location and size, and
    // expose them as the metadata.
    context {
        let cnt-get = _mark-cnt.get().first()
        let loc-lab = label("_mark-loc-" + str(cnt-get))
        let info-lab = if tag == none {
            label("_mark-info-" + str(cnt-get))
        } else {
            tag
        }

        let start = here().position()
        _label-each-child(content, loc-lab)
        _mark-cnt.step()

        context {
            let elems = query(loc-lab)

            let min-y = start.y
            for e in elems {
                let pos = e.location().position()
                if start.x < pos.x and min-y > pos.y {
                    min-y = pos.y
                }
            }

            let end = here().position()

            let size = if scriptlevel == 0 {
                measure($ content $)
            } else if scriptlevel == 1 {
                measure($ script(content) $)
            } else {
                measure($ sscript(content) $)
            }

            let x = start.x
            let y = min-y
            let width = end.x - start.x
            let height = size.height

            let new-padding
            {
                let rest = padding.at("rest", default: 0em).to-absolute()
                let x = padding.at("x", default: rest).to-absolute()
                let left = padding.at("left", default: x).to-absolute()
                let right = padding.at("right", default: x).to-absolute()
                let y = padding.at("y", default: rest).to-absolute()
                let top = padding.at("top", default: y).to-absolute()
                let bottom = padding.at("bottom", default: y).to-absolute()
                new-padding = (left: left, right: right, top: top, bottom: bottom)
            }

            let info = (content: content, x: x, y: y,
                    width: width, height: height,
                    padding: new-padding, color: color)
            [#metadata(info)#info-lab]
        }
    }
}

$
mark(2, tag: #<c1>)
mark(x, tag: #<x1>, color: #blue)
mark(x, tag: #<x1>, color: #black)
$
