#import "util.typ": copy-stroke

#import "@preview/cetz:0.3.4"
#import "@preview/tiptoe:0.3.0"


#let _coerce-anchor(anchor) = {
  assert(type(anchor) == alignment, message: "`anchor` must be `alignment`")
  if anchor.x == none {
    anchor += center
  }
  if anchor.y == none {
    anchor += horizon
  }
  return anchor
}

#let _coerce-pos(pos) = {
  if type(pos) == alignment {
    pos = _coerce-anchor(pos)
    pos = if pos.y == horizon {
      (pos, pos.inv())
    } else {
      (pos.y + center, pos.inv())
    }
  } else if type(pos) == array {
    assert(pos.len() == 2, message: "`pos` must be `anchor` or `(anchor, anchor)`")
    pos = (_coerce-anchor(pos.at(0)), _coerce-anchor(pos.at(1)))
  } else {
    panic("`pos` must be alignment or array")
  }

  return pos
}

#let _coerce-connect(connect) = {
  if type(connect) == array {
    assert(connect.len() == 2, message: "`connect` must be `(anchor, anchor)` or \"elbow\"")

    connect = (
      _coerce-anchor(connect.at(0)),
      _coerce-anchor(connect.at(1)),
    )
  } else if connect != "elbow" {
    panic("`connect` must be `(anchor, anchor)` or \"elbow\"")
  }

  return connect
}


/// Places a custom annotation on previously marked content within a math block.
///
/// This function creates a custom annotation by applying an overlay to content
/// that was previously marked with a specific tag using `core-mark`.
/// It must be used within the same math block as the marked content.
///
/// Use this function as a foundation for defining custom annotation functions.
///
/// *Example*
/// #example(```typ
/// #let myannot(tag, annotation) = {
///   let a = rect(annotation)
///   let overlay(markers) = {
///     let m = markers.first()
///     place(dx: m.x, dy: m.y + m.height, a)
///   }
///   return core-annot(tag, overlay)
/// }
///
/// $
/// mark(x, tag: #<e>)
/// #myannot(<e>)[This is x.]
/// $
/// ```, preview-inset: 20pt)
///
/// -> content
#let core-annot(
  /// The tag associated with the content to annotate.
  /// This tag must match a tag previously used in a `core-mark` call.
  /// -> label | array
  tag,
  /// The function to create the custom annotation overlay.
  /// This function receives the width, height, and color of the marked content (including padding)
  /// and should return content to be placed *over* the marked content.
  /// The signature is `overlay(width, height, color)`.
  /// -> function
  overlay,
) = {
  if type(tag) == label {
    tag = (tag,)
  }

  sym.wj
  context {
    let markers = tag.map(tag => query(selector(tag).before(here())).last().value)

    let hpos = here().position()
    box(place(dx: -hpos.x, dy: -hpos.y, float: false, left + top, overlay(markers)))
    sym.wj
  }
}


/// Places an annotation on previously marked content within a math block.
///
///
/// *Example*
/// ```example
/// $
/// markhl(x, tag: #<e>)
/// #annot(<e>)[Annotation]
/// $
/// #v(1em)
/// ```
///
/// #example(```typ
/// $
/// markrect(integral x dif x, tag: #<x>, color: #blue)
///
/// #annot(<x>, pos: left, dx: -1em)[Annotation.]
/// #annot(<x>, pos: bottom + right, dy: 1em)[Another annotation.]
/// $
/// #v(1em)
/// ```, preview-inset: 20pt)
///
/// -> content
#let annot(
  /// The tag associated with the content to annotate, or array of tags.
  /// -> label | array
  tag,
  /// The content of the annotation. -> content
  annotation,
  /// The position of the annotation relative to the marked content.
  /// -> alignment | (alignment, alignment)
  pos: bottom,
  /// Horizontal offset. -> auto | length
  dx: auto,
  /// Vertical offset. -> auto | length
  dy: auto,
  /// Leader line.
  /// -> none | auto | length | color | gradient | stroke | tiling | dictionary
  leader: auto,
  /// -> length | dictionary
  annot-padding: (x: .08em, y: .16em),
  annot-alignment: auto,
  /// Properties for the annotation text.
  /// If the `fill` property is not specified, it defaults to the marking's color.
  /// -> dictionary
  annot-text-props: (size: .7em),
  /// Properties for the annotation paragraph.
  /// -> dictionary
  annot-par-props: (leading: .4em),
) = {
  pos = _coerce-pos(pos)

  if dx == auto {
    dx = if pos.at(0).x == left and pos.at(1).x == right {
      -.2em
    } else if pos.at(0).x == right and pos.at(1).x == left {
      .2em
    } else {
      0em
    }
  }
  if dy == auto {
    dy = if pos.at(0).y == top and pos.at(1).y == bottom {
      -.2em
    } else if pos.at(0).y == bottom and pos.at(1).y == top {
      .2em
    } else {
      0em
    }
  }

  annotation = {
    show: pad.with(..annot-padding)
    set par(..annot-par-props)
    text(..annot-text-props, annotation)
  }

  context {
    let dx = dx.to-absolute()
    let dy = dy.to-absolute()
    let annot-size = measure(annotation)
    let aw = annot-size.width
    let ah = annot-size.height

    let leader-style = if leader == none or leader == auto {
      (:)
    } else if type(leader) in (length, color, gradient, stroke, tiling) {
      (stroke: leader)
    } else if type(leader) == dictionary {
      leader
    }
    leader-style = (
      stroke: stroke(leader-style.at("stroke", default: .05em).to-absolute()),
      tip: leader-style.at("tip", default: none),
      toe: leader-style.at("tip", default: tiptoe.straight.with(length: 600%)),
      connect: _coerce-connect(leader-style.at("connect", default: (center + horizon, center + horizon))),
    )

    let overlay(infos) = {
      let x = infos.first().x
      let y = infos.first().y
      let w = infos.first().width
      let h = infos.first().height
      let c = infos.first().color

      let leader-style = leader-style
      if leader-style.stroke.paint == auto {
        leader-style.stroke = copy-stroke(leader-style.stroke, paint: c)
      }

      let ax = if pos.at(0).x == left { x } else if pos.at(0).x == right { x + w } else { x + w / 2 }
      ax -= if pos.at(1).x == left { 0pt } else if pos.at(1).x == right { aw } else { aw / 2 }
      ax += dx

      let ay = if pos.at(0).y == top { y } else if pos.at(0).y == bottom { y + h } else { y + h / 2 }
      ay -= if pos.at(1).y == top { 0pt } else if pos.at(1).y == bottom { ah } else { ah / 2 }
      ay += dy

      let annot-text-fill = annot-text-props.at("fill", default: c)
      let annot-alignment = if ax + aw / 2 < x + w / 2 { right } else { left }
      let annotation = {
        set align(annot-alignment)
        set text(annot-text-fill)
        annotation
      }

      place(dx: ax, dy: ay, float: false, left + top, annotation)

      if leader != none {
        for info in infos {
          let x = info.x
          let y = info.y
          let w = info.width
          let h = info.height

          if type(leader-style.connect) == array {
            let c0x = if leader-style.connect.at(0).x == left {
              x
            } else if leader-style.connect.at(0).x == right {
              x + w
            } else {
              x + w / 2
            }
            let c0y = if leader-style.connect.at(0).y == top {
              y
            } else if leader-style.connect.at(0).y == bottom {
              y + h
            } else {
              y + h / 2
            }
            let c1x = if leader-style.connect.at(1).x == left {
              ax
            } else if leader-style.connect.at(1).x == right {
              ax + aw
            } else {
              ax + aw / 2
            }
            let c1y = if leader-style.connect.at(1).y == top {
              ay
            } else if leader-style.connect.at(1).y == bottom {
              ay + ah
            } else {
              ay + ah / 2
            }
            let cdx = c1x - c0x
            let cdy = c1y - c0y

            let l0x = c0x
            let l0y = c0y
            let l1x = c1x
            let l1y = c1y

            if leader-style.connect.at(0) == center + horizon {
              if calc.abs(cdx.pt()) * h < calc.abs(cdy.pt()) * w {
                if cdy > 0pt {
                  l0x = c0x + h / 2 / cdy * cdx
                  l0y = y + h
                } else {
                  l0x = c0x - h / 2 / cdy * cdx
                  l0y = y
                }
              } else {
                if cdx > 0pt {
                  l0x = x + w
                  l0y = c0y + w / 2 / cdx * cdy
                } else {
                  l0x = x
                  l0y = c0y - w / 2 / cdx * cdy
                }
              }
            }

            if leader-style.connect.at(1) == center + horizon {
              if calc.abs(cdx.pt()) * ah < calc.abs(cdy.pt()) * aw {
                if cdy > 0pt {
                  l1x = c1x - ah / 2 / cdy * cdx
                  l1y = ay
                } else {
                  l1x = c1x + ah / 2 / cdy * cdx
                  l1y = ay + ah
                }
              } else {
                if cdx > 0pt {
                  l1x = ax
                  l1y = c1y - aw / 2 / cdx * cdy
                } else {
                  l1x = ax + aw
                  l1y = c1y + aw / 2 / cdx * cdy
                }
              }
            }

            if leader == auto {
              let leader-len = calc.norm((l1x - l0x).pt(), (l1y - l0y).pt())
              if leader-len <= .4em.to-absolute().pt() {
                continue
              }
            }

            {
              set place(left + top, float: false) // For RTL document.
              tiptoe.curve(
                stroke: leader-style.stroke,
                tip: leader-style.tip,
                toe: leader-style.toe,
                curve.move((l0x, l0y)),
                curve.line((l1x, l1y)),
              )
            }
          } else {
            let corner = .2em.to-absolute()
            let components = if ax > x + corner or ax + aw < x + w - corner {
              if ax + aw / 2 < x + w / 2 {
                if ay + ah < y or ay + ah > y + h {
                  let l0x = calc.max(x + corner, ax + aw)
                  let l0y = if ay + ah < y { y } else if y + h < ay + ah { y + h }
                  (
                    curve.move((l0x, l0y)),
                    curve.line((l0x, ay + ah)),
                    curve.line((ax, ay + ah)),
                  )
                } else {
                  (
                    curve.move((x, ay + ah)),
                    curve.line((ax, ay + ah)),
                  )
                }
              } else {
                if ay + ah < y or ay + ah > y + h {
                  let l0x = calc.min(x + w - corner, ax)
                  let l0y = if ay + ah < y { y } else if y + h < ay + ah { y + h }
                  (
                    curve.move((l0x, l0y)),
                    curve.line((l0x, ay + ah)),
                    curve.line((ax + aw, ay + ah)),
                  )
                } else {
                  (
                    curve.move((x + w, ay + ah)),
                    curve.line((ax + aw, ay + ah)),
                  )
                }
              }
            } else {
              if ay > y + h {
                (
                  curve.move((x + w / 2, y + h)),
                  curve.line((x + w / 2, ay)),
                )
              } else {
                (
                  curve.move((x + w / 2, y)),
                  curve.line((x + w / 2, ay + ah)),
                )
              }
            }

            {
              set place(left + top, float: false) // For RTL document.
              tiptoe.curve(
                stroke: leader-style.stroke,
                tip: leader-style.tip,
                toe: leader-style.toe,
                ..components,
              )
            }
          }
        }
      }
    }

    return core-annot(tag, overlay)
  }
}


/// Places an cetz canvas on previously marked content within a math block.
///
///
/// *Example*
/// ```example
/// #import "@preview/cetz:0.3.4"
///
/// $
///   mark(x, tag: #<0>)
///   + mark(y, tag: #<1>)
///
///   #annot-cetz((<0>, <1>), {
///     import cetz.draw: *
///     content((1, -.6), [Annotation], anchor: "north", name: "a")
///     set-style(stroke: .7pt, mark: (start: "straight", scale: 0.6))
///     line("0", "a")
///     line("1", "a")
///   })
/// $
/// #v(1em)
/// ```
///
/// -> content
#let annot-cetz(
  /// The tag associated with the content to annotate, or array of tags.
  /// -> label | array
  tag,
  /// A code block given to cetz canvas.
  /// -> array
  drawable,
) = {
  let overlay(infos) = {
    let origin = infos.first()
    let preamble = infos
      .map(info => {
        cetz.draw.rect(
          (info.x - origin.x, -(info.y - origin.y)),
          (info.x + info.width - origin.x, -(info.y + info.height - origin.y)),
          name: str(info.tag),
          stroke: none,
          fill: none,
        )
      })
      .sum()
    let loc-lab = <_mannot-annot-cetz-loc>
    let loc-lab-content = cetz.draw.content((0, 0), [#none#loc-lab])

    place(hide(cetz.canvas(loc-lab-content + preamble + drawable)))

    context {
      let cpos = query(selector(loc-lab).before(here())).last().location().position()
      place(dx: origin.x - cpos.x, dy: origin.y - cpos.y, cetz.canvas(preamble + drawable))
    }
  }

  core-annot(tag, overlay)
}
