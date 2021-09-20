# `fennel-static-readline`

This repo is an example of how to create a statically linked binary
that includes readline. It uses an `alpine` docker image which install
static versions of `readline` and `ncurses`, build a static version of
the `lua-readline` bindins, then uses those to build a static binary.

The following libraries are used from Alpine packages:

- `/usr/lib/libreadline.a` from `readline-static`
- `/usr/lib/libhistory.a` from `readline-static`
- `/usr/lib/libncursesw.a` from `ncurses-static`

# Prerequisites

- `git`
- `make`
- `docker`

# Building

To build the static binary, run `make fennel-static-readline` in the
root of this repo. (This is also the default make target, so just
running `make` on its own will have the same effect.)

To get a gzipped version of the binary, run `make
fennel-static-readline.gz`.

# How big is it?

All the following numbers are based on the results I got on my
machine. These sizes will be output to the `sizes` directory each time
the relevant make targets are built.

- Before running `strip`, the binary is 1.6M. (see `sizes/initial.txt`)
- After running `strip`, it shrinks to 720K. (see `sizes/stripped.txt`)
- After gzipping, it shrinks to 316K. (see `sizes/gzipped.txt`)


[Lua-cURLv3]: https://github.com/Lua-cURL/Lua-cURLv3
