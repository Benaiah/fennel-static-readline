FROM alpine

ADD fennel /usr/src/fennel
ADD src /usr/src/fennel-static-http

RUN apk add make lua5.3 && \
    ln -s /usr/bin/lua5.3 /usr/bin/lua && \
    cd /usr/src/fennel && make && \
    ln -s /usr/src/fennel/fennel /usr/bin/fennel

ENV LUA_PATH="?.lua;/usr/src/fennel/?.lua;/usr/src/fennel-static-http/?.lua;/usr/src/fennel-static-http/Lua-cURLv3/src/lua/?.lua"
ENV FENNEL_PATH="?.fnl;/usr/src/fennel/?.fnl;/usr/src/fennel-static-http/?.fnl"

RUN apk add gcc musl-dev lua5.3-dev curl-dev curl-static nghttp2-static openssl-libs-static zlib-static

RUN cd /usr/src/fennel-static-http && make clean && make
