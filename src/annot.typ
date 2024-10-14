#import "util.typ": copy-stroke

#let _place-path-arrow(
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


/// Add an annotation to the marked content.
/// The main purpose of this function is to create custom annotating functions.
///
/// - tag (label): The tag of the target.
/// - overlay (none, function): `fg(width, height, color)` is placed on the target.
#let core-annot(tag, overlay: none) = {
  let info = query(selector(tag).before(here())).last()
  info = info.value

  let hpos = here().position()
  let dx = info.x - hpos.x
  let dy = info.y - hpos.y
  let width = info.width
  let height = info.height
  let color = info.color
  place(dx: dx, dy: dy, overlay(width, height, color))
}

/// Annotate the marked content with arrow and text.
///
/// - tag (label): The tag of the target content.
/// - annotation (content): Annotation to the target.
/// - alignment (alignment): Direction of annotating.
/// - yshift (length): Distance between annotation and the target.
/// - text-props (dictionary): Properties of annotation text.
/// - arrow (auto, color, length, dictionary, stroke):
///     Properties of arrow stroke.
#let annot(
  tag,
  annotation,
  alignment: center + bottom,
  yshift: .2em,
  text-props: (size: .6em),
  arrow: auto,
) = {
  assert(
    alignment.x == left or alignment.x == center or alignment.x == right or alignment.x == none,
    message: "The field `x` of the argument `alignment` of the function
        `annot` must be `left`, `center`, `right` or `none`.",
  )
  assert(
    alignment.y == top or alignment.y == bottom or alignment.y == none,
    message: "The field `y` of the argument `alignment` of the function
        `annot` must be `top`, `bottom` or `none`.",
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


  context {
    let text-props = text-props
    text-props.insert("bottom-edge", text-props.at("bottom-edge", default: "descender"))
    let annot-tsize = text-props.remove("size", default: 1em).to-absolute()
    set text(size: annot-tsize)

    context {
      let annot-content = text(..text-props, annotation)
      let annot-size = measure(annot-content)
      let annot-padding = .1em

      let overlay(width, height, color) = text(
        size: annot-tsize,
        {
          let annot-content = text(annot-content)
          if text-props.at("fill", default: auto) == auto {
            annot-content = text(color, annot-content)
          }

          let arrow = arrow
          if arrow == auto {
            arrow = if yshift > .4em {
              .06em
            } else {
              none
            }
          }

          if arrow == none {
            let dx = width / 2 + if alignment.x == center {
              -annot-size.width / 2
            } else if alignment.x == left {
              -annot-size.width
            }
            let dy = if alignment.y == bottom {
              height + yshift
            } else {
              -annot-size.height - yshift
            }

            // Place the annotation.
            place(annot-content, dx: dx, dy: dy)
          } else {
            let arrow = stroke(arrow)
            if arrow.thickness == auto {
              arrow = copy-stroke(arrow, (thickness: .06em))
            }
            if arrow.paint == auto {
              arrow = copy-stroke(arrow, (paint: color))
            }

            let p3x = width / 2
            let p3y = if alignment.y == bottom {
              height + arrow.thickness
            } else {
              -arrow.thickness
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

            if arrow.thickness > 0pt {
              // Place the arrow.
              if alignment.x == center {
                _place-path-arrow(stroke: arrow, tail-length: .3em, (p2x, p2y), (p3x, p3y))
              } else {
                _place-path-arrow(stroke: arrow, tail-length: .3em, (p1x, p1y), (p2x, p2y), (p3x, p3y))
              }
            }

            // Place the annotation.
            if alignment.x == right {
              place(annot-content, dx: p2x + annot-padding, dy: p2y - annot-size.height - annot-padding)
            } else if alignment.x == left {
              place(
                annot-content,
                dx: p2x - annot-size.width - annot-padding,
                dy: p2y - annot-size.height - annot-padding,
              )
            } else {
              if alignment.y == bottom {
                place(annot-content, dx: p2x - annot-size.width / 2, dy: p2y + annot-padding)
              } else {
                place(annot-content, dx: p2x - annot-size.width / 2, dy: p2y - annot-size.height - annot-padding)
              }
            }
          }
        },
      )

      return core-annot(tag, overlay: overlay)
    }
  }
}
