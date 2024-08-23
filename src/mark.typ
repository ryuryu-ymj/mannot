#let _mark-cnt = counter("_mark")

#let _sequence-func = (math.text("x") + math.text("y")).func()
#let _aling-point-func = $&$.body.func()


#let _remove-leading-h(content) = {
  if content.func() == _sequence-func {
    let children = content.children
    if children.len() == 0 {
      return (none, none)
    }
    let rest
    let remove
    let leadingCount = 0
    for c in children {
      let (crest, cremove) = _remove-leading-h(c)
      rest = crest
      remove += cremove
      if rest != none {
        break
      }
      leadingCount += 1
    }
    children = children.slice(leadingCount)
    children.first() = rest
    let rest = _sequence-func(children)
    return (rest, remove)
  } else if content.func() == h {
    return (none, content)
  } else {
    return (content, none)
  }
}


#let _remove-trailing-h(content) = {
  if content.func() == _sequence-func {
    let children = content.children
    if children.len() == 0 {
      return (none, none)
    }
    let rest
    let remove
    let trailingCount = 0
    for c in children.rev() {
      let (crest, cremove) = _remove-leading-h(c)
      rest = crest
      remove += cremove
      if rest != none {
        break
      }
      trailingCount += 1
    }
    children = children.slice(0, children.len() - trailingCount)
    children.last() = rest
    let rest = _sequence-func(children)
    return (rest, remove)
  } else if content.func() == h {
    return (none, content)
  } else {
    return (content, none)
  }
}


#let _label-each-child(content, label) = {
  if content.func() == math.equation {
    let body = _label-each-child(content.body, label)
    return math.equation(body)
  } else if content.func() == _sequence-func {
    // If `content` is the sequence of contents,
    // then put `lable` on each child.
    let children = content.children
      .filter((c) => c != [ ])
      .map((c) => {
        _label-each-child(c, label)
      })
    return content.func()(children)
  } else if (
      content.func() == _aling-point-func
      or content.func() == h
      or content.func() == v
    ) {
    // Do not put `label` on layout contents such as align-point(),
    // h(), or v(), in order to avoid broken layout.
    return content
  } else {
    return [#content#label]
  }
}


#let core-mark(body, tag: none, color: black, bg: none, fg: none, padding: (:), scriptlevel: 0) = {
  // Extract leading/trailing horizontal space from body.
  let (body, leading-h) = _remove-leading-h(body)
  let (body, trailing-h) = _remove-trailing-h(body)
  leading-h

  _mark-cnt.step()

  // Place `bg(width, height, color)` behind the `body` using the metadata.
  if bg != none {
    context {
      let cnt-get = _mark-cnt.get().first()
      let info-lab = label("_mark-info-" + str(cnt-get))

      let info = query(selector(info-lab).after(here())).first().value
      let hpos = here().position()
      let dx = info.x - hpos.x
      let dy = info.y - hpos.y
      place(dx: dx, dy: dy, bg(info.width, info.height, color))
    }
    h(0pt)
  }


  // Produce a labeled `body`, measure its position and size, and
  // expose them as the metadata.
  // The body's top-left position (x, y) and its size (width, height)
  // is determined in the following steps:
  //   1. Call `here().position()` before/after `body` to find the x and the width.
  //   2. Call `measure($ body $)` to find the height.
  //   3. Labeld each child of content sequence to find the y.
  context {
    set math.equation(numbering: none)

    let cnt-get = _mark-cnt.get().first()
    let loc-lab = label("_mark-loc-" + str(cnt-get))
    let info-lab = label("_mark-info-" + str(cnt-get))

    let start = here().position()
    _label-each-child(body, loc-lab)

    context {
      let end = here().position()
      let elems = query(loc-lab)

      let min-y = start.y
      for e in elems {
        let pos = e.location().position()
        if min-y > pos.y {
          min-y = pos.y
        }
      }

      let size = if scriptlevel == 0 {
        measure($ body $)
      } else if scriptlevel == 1 {
        measure($ script(body) $)
      } else {
        measure($ sscript(body) $)
      }

      let padding = padding
      {
        let rest = padding.at("rest", default: 0em).to-absolute()
        let x = padding.at("x", default: rest).to-absolute()
        let left = padding.at("left", default: x).to-absolute()
        let right = padding.at("right", default: x).to-absolute()
        let y = padding.at("y", default: rest).to-absolute()
        let top = padding.at("top", default: y).to-absolute()
        let bottom = padding.at("bottom", default: y).to-absolute()
        padding = (left: left, right: right, top: top, bottom: bottom)
      }

      let x = start.x - padding.left
      let y = min-y - padding.top
      let width = end.x + padding.right - start.x
      let height = size.height + padding.top + padding.bottom

      let info = (body: body, x: x, y: y,
          width: width, height: height, color: color)
      [#metadata(info)#info-lab]

      // Place `fg(width, height, color)` in front of the `body`.
      if fg != none {
        let hpos = here().position()
        let dx = x - hpos.x
        let dy = y - hpos.y
        place(dx: dx, dy: dy, fg(width, height, color))
      }

      // Place added annotation and insert top/bottom margin.
      if tag != none {
        let elems = query(tag)
        if elems.len() > 1 {
          panic("tag `" + repr(tag) + "` occuers multiple times in the document")
        }

        if elems.len() > 0 {
          let info = elems.first().value
          let fg = info.fg
          let top-margin = info.top-margin
          let bottom-margin = info.bottom-margin

          if fg != none {
            let hpos = here().position()
            if fg != none {
              let dx = x - hpos.x
              let dy = y - hpos.y
              place(dx: dx, dy: dy, fg(width, height, color))
            }
          }

          if top-margin != 0pt {
            let spacing = padding.top + top-margin - .1em
            math.attach(
              math.limits(hide(scale($ body $, x: 0%, reflow: true))),
              // math.limits(scale($ body $, x: 20%, reflow: true)),
              t: v(spacing),
              // t: rect(fill: red, width: 1pt, height: spacing),
            )
          }
          if bottom-margin != 0pt {
            let spacing = padding.bottom + bottom-margin - .1em
            math.attach(
              math.limits(hide(scale($ body $, x: 0%, reflow: true))),
              // math.limits(scale($ body $, x: 20%, reflow: true)),
              b: v(spacing),
              // b: rect(fill: red, width: 1pt, height: spacing),
            )
          }
        }
      }
    }
  }

  trailing-h
}


/// - tag (label):
/// - fg (none, function):
/// - top-margin (length):
/// - bottom-margin (length):
#let core-add-annot(tag, fg: none, top-margin: 0pt, bottom-margin: 0pt) = {
  let info = (fg: fg, top-margin: top-margin, bottom-margin: bottom-margin)
  return h(0pt) + [#metadata(info)#tag]
}


/// Define the target of annotation within some math block.
///
/// - body (content): The target of annotation.
/// - tag (label): Optinal tag. If you mark content with a tag,
///   you can annotate that content by specifying the tag.
#let mark(body, tag: none, color: auto, fill: auto, stroke: (:), radius: (:), padding: (y: .1em), scriptlevel: 0) = {
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

  let bg(width, height, _) = {
    if fill == none and stroke == none {
      none
    } else {
      rect(width: width, height: height, fill: fill, stroke: stroke, radius: radius)
    }
  }

  return core-mark(body, tag: tag, color: color, bg: bg, padding: padding, scriptlevel: scriptlevel)
}
