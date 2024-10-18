default:
    just --list

clean:
    find . -name "*.pdf" -type f -delete && \
    find . -name "*.png" -type f -delete && \
    find . -name "*.svg" -type f -delete

doc:
    typst compile docs/doc.typ --root ./

tests:
    for f in tests/*.typ; \
    do \
        echo "Compile $f."; \
        typst compile "$f" --root ./; \
    done

test file:
    typst compile {{file}} --root ./

example:
    for f in examples/*.typ; \
    do \
        echo "Compile $f."; \
        typst compile "$f" -f svg --root ./; \
    done
