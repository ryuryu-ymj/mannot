#import "/src/mark.typ": mark, markhl
#import "/src/annot.typ": annot


// Marked and annotated content can be measured; marks and annotations do not
// affect layout, so the size equals that of the unmarked content.
#context {
  let plain = measure($x + y$)
  let marked = measure($mark(x, tag: #<a>) + y #annot(<a>)[annotation]$)
  let highlighted = measure($markhl(x, tag: #<b>) + y #annot(<b>)[annotation]$)
  let untagged = measure($mark(x) + y$)
  assert.eq(marked, plain)
  assert.eq(highlighted, plain)
  assert.eq(untagged, plain)
  [measured: #marked, plain: #plain]
}

// Marking and annotating still work after measuring.
$
  mark(x, tag: #<c>) + y
  #annot(<c>)[annotation]
$
