#import "@preview/cetz:0.2.2"

#let isin-alignannot = state("_isin_alignannot", false)
#let alignannot-cnt = counter("_alignannot")

#let annot(tag, annotation, yshift: auto) = {
    set text(size: 0.5em)

    context {
        let mark = query(selector(tag).before(here())).first().value

        if isin-alignannot.get() {
            let cnt-get = alignannot-cnt.get().first()
            let info-lab = label("_annot_info_" + str(cnt-get))
            let info = (mark: mark, annotation: annotation, yshift: yshift)
            [#metadata(info)#info-lab]
        } else {
            let canvas = cetz.canvas({
                import cetz.draw: *

                let color = mark.color
                content((0, -.6 - yshift.to-absolute().cm()), padding: .16em, text(fill: color, annotation), anchor: "west", name: "content")
                line("content.south-east", "content.south-west", (0, 0), mark: (end: "straight"), stroke: color, name: "line")
                // line((0, 0), "line.start", mark: (start: "straight"), stroke: color)
            })

            let hpos = here().position()
            let dx = mark.x - mark.padding.left + mark.width / 2 - hpos.x - 2.1pt
            let dy = mark.y + mark.height + mark.padding.bottom - hpos.y + 1.3pt

            let size = measure(canvas)
            // place(rect(width: size.width, height: size.height, fill: red.opacify(-50%)), dx: dx, dy: dy)

            $ limits(#none)^#v(0em)_#v(size.height) $
            place(canvas, dx: dx, dy: dy)
        }
    }
}

#let alignannot(annotations) = {
    set text(size: 0.5em)

    // $#h(0em)$
    isin-alignannot.update(true)
    annotations
    isin-alignannot.update(false)

    context {
        let cnt-get = alignannot-cnt.get().first()
        let info-lab = label("_annot_info_" + str(cnt-get))
        let info = query(info-lab).map((e) => e.value)

        for i in info {
            let canvas = cetz.canvas({
                import cetz.draw: *

                let color = i.mark.color
                // content((0, -.6 - i.yshift.to-absolute().cm()), padding: .16em, text(fill: color, annotation), anchor: "west", name: "content")
                content((0, -.6), padding: .16em, text(fill: color, i.annotation), anchor: "west", name: "content")
                line("content.south-east", "content.south-west", (0, 0), mark: (end: "straight"), stroke: color, name: "line")
                // line((0, 0), "line.start", mark: (start: "straight"), stroke: color)
            })

            let hpos = here().position()
            let dx = i.mark.x - i.mark.padding.left + i.mark.width / 2 - hpos.x - 2.1pt
            let dy = i.mark.y + i.mark.height + i.mark.padding.bottom - hpos.y + 1.3pt

            let size = measure(canvas)
            // place(rect(width: size.width, height: size.height, fill: red.opacify(-50%)), dx: dx, dy: dy)

            place(canvas, dx: dx, dy: dy)
        }

        $ limits(#none)^#v(0em)_#v(1em) $
    }


    alignannot-cnt.step()
}
