# Notes on Conductivity

Build by calling `make`, and it will dump every pdf into the pdfs directory.
Uses subfiles etc.

### To add a new section:
1. Create the `example.tex` file in `/tex`.
  * It must begin \documentclass[../main.tex]{subfiles}
  * Ideally it should all be wrapped in one or more `\section`s, so that the table of contents lines up with subfile boundaries.
1. Reference it in `main.tex` as `\subfile{tex/example}`
1. That's it, run `make` and it should be taken into account, provided it is simple.