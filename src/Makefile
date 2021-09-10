# This Makefile is supposed to be run within the docker container

fennel-static-http: Lua-cURLv3/lcurl-linked.a
	CC_OPTS="-static -no-pie" fennel --compile-binary \
		main.fnl fennel-static-http \
		/usr/lib/lua5.3/liblua.a /usr/include/lua5.3 \
		--native-module Lua-cURLv3/lcurl-linked.a

Lua-cURLv3/src:
	if [ ! - d Lua-cURLv3/src ]; then \
		echo "Remember to run \"git submodule init && git submodule update \" in the root of the project (outside of the build container)!" \
		exit 1 \
	fi

Lua-cURLv3/lcurl.a: Lua-cURLv3/src
	$(MAKE) -C Lua-cURLv3/ lcurl.a LUA_IMPL=5.3 LUA_VERSION=5.3 LUA_INC=/usr/include/lua5.3

Lua-cURLv3/lcurl-linked.a: Lua-cURLv3/lcurl.a
	./create-lcurl-linked.sh

clean:
	rm -rf fennel-static-http
	$(MAKE) -C Lua-cURLv3/ clean

.PHONY: clean
