#import "util.typ": copy-stroke
#import "mark.typ": core-annot


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


/// Annotate the marked content with arrow.
///
/// - tag (label): The tag of the target content.
/// - annotation (content): The annotation to the target.
/// - alignment (alignment): The direction of annotating.
/// - yshift (length): Distance between annotation and the target.
/// - margin (auto, length): Margin inserted above/below the equation.
/// - text-props (dictionary): Properties of annotation text.
/// - arrow-stroke (auto, color, length, dictionary, stroke):
///     Properties of arrow stroke.
#let annot(
  tag,
  annotation,
  alignment: center + bottom,
  yshift: .6em,
  margin: auto,
  text-props: (size: .6em),
  arrow-stroke: .06em
) = {
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

  context {
    let text-props = text-props
    let annot-tsize = text-props.remove("size", default: 1em).to-absolute()
    set text(size: annot-tsize)

    context {
      let annot-content = text(..text-props, annotation)
      let annot-size = measure(annot-content)
      let annot-padding = 0.3em

      let fg(width, height, color) = text(size: annot-tsize, {
        let annot-content = text(annot-content)
        if text-props.at("fill", default: auto) == auto {
          annot-content = text(color, annot-content)
        }

        let arrow-stroke = arrow-stroke
        if arrow-stroke.paint == auto {
          arrow-stroke = copy-stroke(arrow-stroke, (paint: color))
        }

        let p3x = width / 2
        let p3y = if alignment.y == bottom {
          height + arrow-stroke.thickness
        } else {
          -arrow-stroke.thickness
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
          _place-path-arrow(stroke: arrow-stroke, tail-length: .3em, (p2x, p2y), (p3x, p3y))
        } else {
          _place-path-arrow(stroke: arrow-stroke, tail-length: .3em, (p1x, p1y), (p2x, p2y), (p3x, p3y))
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
      })

      let top-margin = 0pt
      if alignment.y == top {
        if margin != auto {
          top-margin = margin
        } else {
          top-margin = annot-padding + yshift + annot-size.height
        }
        top-margin = top-margin.to-absolute()
      }

      let bottom-margin = 0pt
      if alignment.y == bottom {
        if margin != auto {
          bottom-margin = margin
        } else {
          bottom-margin = annot-padding * 2 + yshift + annot-size.height
        }
        bottom-margin = bottom-margin.to-absolute()
      }

      return core-annot(tag, fg: fg, top-margin: top-margin, bottom-margin: bottom-margin)
    }
  }
}
