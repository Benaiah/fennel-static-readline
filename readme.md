# `fennel-static-http`

This repo is an example of how to create a statically linked binary
that can make HTTPS requests. It uses an `alpine` docker image to
build a static version of [Lua-cURLv3][Lua-cURLv3], then creates a
statically linked library out of the resulting file
(`src/Lua-cURLv3/lcurl.a`) as well as the following static libraries
which it requires:

- `/lib/libz.a` from `zlib-static`
- `/usr/lib/libbrotlicommon.a` from `brotli-static`
- `/usr/lib/libbrotlidec.a` from `brotli-static`
- `/usr/lib/libbrotlienc.a` from `brotli-static`
- `/usr/lib/libcrypto.a` from `openssl-libs-static`
- `/usr/lib/libssl.a` from `openssl-libs-static`
- `/usr/lib/libnghttp2.a` from `nghttp2-static`
- `/usr/lib/libcurl.a` from `curl-static`

See `src/create-lcurl-linked.sh` for the script that creates the
static archive containing all the necessary libraries. This is then
included in the binary by passing `--native-module
Lua-cURLv3/lcurl-linked.a` to `fennel --compile-binary`

# Prerequisites

- `git`
- `make`
- `docker`

# Building

To build the static binary, run `make fennel-static-http` in the root
of this repo. (This is also the default make target, so just running
`make` on its own will have the same effect.)

To get a gzipped version of the binary, run `make fennel-static-http.gz`.

# How big is it?

All the following numbers are based on the results I got on my
machine. These sizes will be output to the `sizes` directory each time
the relevant make targets are built.

- Before running `strip`, the binary is 17M. (see `sizes/initial.txt`)
- After running `strip`, it shrinks to 3.3M. (see `sizes/stripped.txt`)
- After gzipping, it shrinks to 1.7M. (see `sizes/gzipped.txt`)


[Lua-cURLv3]: https://github.com/Lua-cURL/Lua-cURLv3
