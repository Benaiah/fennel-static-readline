FROM alpine

ADD src /usr/src/fennel-static-readline

RUN apk add make lua5.3 && \
    ln -s /usr/bin/lua5.3 /usr/bin/lua && \
    cd /usr/src/fennel-static-readline/fennel && make && \
    ln -s /usr/src/fennel-static-readline/fennel/fennel /usr/bin/fennel

ENV LUA_PATH="?.lua;/usr/src/fennel-static-readline/?.lua;/usr/src/fennel-static-readline/lua-readline/?.lua"
ENV FENNEL_PATH="?.fnl;/usr/src/fennel/?.fnl;/usr/src/fennel-static-readline/?.fnl"

RUN apk add gcc musl-dev lua5.3-dev readline-dev readline-static ncurses-static

RUN cd /usr/src/fennel-static-readline && make clean && make
