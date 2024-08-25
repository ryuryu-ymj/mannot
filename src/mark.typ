#let _mark-cnt = counter("_mark")

#let _sequence-func = (math.text("x") + math.text("y")).func()
#let _align-point-func = $&$.body.func()


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
    // then put `label` on each child.
    let children = content.children
      .filter((c) => c != [ ])
      .map((c) => {
        _label-each-child(c, label)
      })
    return content.func()(children)
  } else if (
      content.func() == _align-point-func
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


/// Mark the part of a math block.
/// The main purpose of this function is to create custom marking functions.
///
/// - body (content): The target of marking.
/// - tag (label): Optional tag. If you mark content with a tag,
///     you can annotate it by specifying the tag.
/// - color (color): Color used for `bg`, `fg` and annotations.
/// - bg (none, function): `bg(width, height, color)` is placed behind the `body`.
/// - fg (none, function): `fg(width, height, color)` is placed in front of the `body`.
/// - padding (dictionary): Padding for `bg`, `fg` and annotations.
/// - scriptlevel (auto, 0, 1, 2): 0: normal, 1: script, 2: scriptscript,
///     auto: Automatically determined.
#let core-mark(body, tag: none, color: black, bg: none, fg: none, padding: (:), scriptlevel: auto) = {
  // Extract leading/trailing horizontal space from body.
  let (body, leading-h) = _remove-leading-h(body)
  let (body, trailing-h) = _remove-trailing-h(body)
  leading-h

  _mark-cnt.step()

  // Place `bg(width, height, color)` behind the `body` using the metadata.
  if bg != none {
    context {
      let cnt-get = _mark-cnt.get().first()
      let info-lab = label("_mannot-mark-info-" + str(cnt-get))

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
  //   3. Labeled each child of content sequence to find the y.
  context {
    set math.equation(numbering: none)

    let cnt-get = _mark-cnt.get().first()
    let loc-lab = label("_mannot-mark-loc-" + str(cnt-get))
    let info-lab = label("_mannot-mark-info-" + str(cnt-get))

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

      let size
      if scriptlevel == 0 {
        size = measure($ body $)
      } else if scriptlevel == 1 {
        size = measure($ script(body) $)
      } else if scriptlevel == 2 {
        size = measure($ sscript(body) $)
      } else {
        // Find scriptlevel.
        let width = end.x - start.x
        size = measure($ body $)
        let size1 = measure($ script(body) $)
        let size2 = measure($ sscript(body) $)
        if width < size.width - .01pt {
          if calc.abs(width - size1.width) < .01pt {
            size = size1
          } else if calc.abs(width - size2.width) < .01pt {
            size = size2
          }
        }
      }

      let padding = padding
      {
        let rest = padding.at("rest", default: 0pt).to-absolute()
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
      let width = end.x + padding.right - x
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
          panic("tag `" + repr(tag) + "` occurs multiple times in the document")
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
              // t: v(spacing),
              t: rect(fill: red, width: 1pt, height: spacing),
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


/// Add an annotation to the marked content.
/// The main purpose of this function is to create custom annotating functions.
///
/// - tag (label): The tag of the target.
/// - fg (none, function): `fg(width, height, color)` is placed on the target.
/// - top-margin (length): Margin inserted above the target.
/// - bottom-margin (length): Margin inserted below the target.
#let core-annot(tag, fg: none, top-margin: 0pt, bottom-margin: 0pt) = {
  let info = (fg: fg, top-margin: top-margin, bottom-margin: bottom-margin)
  return h(0pt) + [#metadata(info)#tag]
}


/// Mark the part of a math block with highlighting.
///
/// - body (content): The target of highlighting and annotation.
/// - tag (none, label): Optional tag. If you mark content with a tag,
///     you can annotate it by specifying the tag.
/// - color (auto, color): Marking color used for highlighting and annotation.
/// - fill (auto, none, color, gradient, pattern): The property of highlighting rect.
/// - stroke (none, auto, length, color, gradient, stroke, pattern, dictionary): The property of highlighting rect.
/// - radius (relative, dictionary): The property of highlighting rect.
/// - scriptlevel (auto, 0, 1, 2): 0: normal, 1: script, 2: scriptscript,
///     auto: Automatically determined.
#let mark(body, tag: none, color: auto, fill: auto, stroke: none, radius: (:), padding: (y: .1em), scriptlevel: auto) = {
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
