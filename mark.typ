#let _mark-cnt = counter("_mark")

#let _sequence-func = (math.text("x") + math.text("y")).func()

#let _label-each-child(content, label) = {
    if content.func() == _sequence-func {
        // If `content` is sequence of contents,
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


#let mark(content, tag: none, annot: none, color: orange, fill: auto, stroke: (:), radius: (:), padding: (y: 0.1em), slevel: 0) = {
    if fill == auto {
        fill = color.lighten(40%).desaturate(40%)
    }

    {
        let padding-rest = padding.at("rest", default: 0em)
        let padding-x = padding.at("x", default: padding-rest)
        padding.insert("left", padding.at("left", default: padding-x))
        padding.insert("right", padding.at("right", default: padding-x))
        let padding-y = padding.at("y", default: padding-rest)
        padding.insert("top", padding.at("top", default: padding-y))
        padding.insert("bottom", padding.at("bottom", default: padding-y))
    }

    // Place a highlight rect behind the `content`.
    context{
        let cnt-get = _mark-cnt.get().first()
        let info-lab
        if tag == none {
            info-lab = label("_mark-info-" + str(cnt-get))
        } else {
            info-lab = tag
        }

        let info = query(selector(info-lab).after(here())).first().value
        let hpos = here().position()
        let dx = info.x - padding.left - hpos.x
        let dy = info.y - padding.top - hpos.y
        let width = info.width + padding.left + padding.right
        let height = info.height + padding.top + padding.bottom
        place(dx: dx, dy: dy, rect(width: width, height: height, fill: fill, stroke: stroke, radius: radius))
    }

    context {
        let cnt-get = _mark-cnt.get().first()
        let loc-lab = label("_mark-loc-" + str(cnt-get))
        let info-lab
        if tag == none {
            info-lab = label("_mark-info-" + str(cnt-get))
        } else {
            info-lab = tag
        }

        let start = here().position()
        _label-each-child(content, loc-lab)
        _mark-cnt.step()

        context {
            let elems = query(loc-lab)

            // place(text(8pt)[#elems.len()])
            // let start = elems.first().location().position()
            let min-y = start.y
            for e in elems {
                let pos = e.location().position()
                // absolute-place(dx: pos.x, dy: pos.y, circle(fill: green, radius: 1.2pt))
                if start.x < pos.x and min-y > pos.y {
                    min-y = pos.y
                }
            }

            let end = here().position()
            // absolute-place(dx: end.x, dy: end.y, circle(fill: red, radius: 1.2pt))
            // absolute-place(dx: start.x, dy: start.y, circle(fill: blue, radius: 1.2pt))

            let size
            if slevel == 0 {
                size = measure($ content $)
            } else if slevel == 1 {
                size = measure($ script(content) $)
            } else {
                size = measure($ sscript(content) $)
            }

            let x = start.x
            let y = min-y
            let width = end.x - start.x
            let height = size.height

            let info = (x: x, y: y, width: width, height: height, padding: padding, color: color)
            [#metadata(info)#info-lab]
        }
    }
}
