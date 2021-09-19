# This Makefile is supposed to be run within the docker container

fennel-static-http: lua-readline/C-readline.a fennel fennel/fennel
	FENNEL_DEBUG=1 FENNEL_SRC="$$(pwd)/fennel" FENNEL_PATH="$$(pwd)/fennel/src/?.fnl" LUA_PATH="$$(pwd)/lua-readline/?.lua" CC_OPTS="-static -no-pie" \
		./fennel/fennel --lua lua5.3 --no-compiler-sandbox --compile-binary \
		./fennel/src/launcher.fnl fennel-static-readline \
		/usr/lib/lua5.3/liblua.a /usr/include/lua5.3 \
		--native-module lua-readline/C-readline.a \
		--rename-native-module readline C-readline \
		--native-library /usr/lib/libreadline.a \
		--native-library /usr/lib/libhistory.a \
		--native-library /usr/lib/libncursesw.a

fennel:
	if [ ! - d fennel ]; then \
		echo "fennel directory not present" \
		exit 1 \
	fi

fennel/fennel:
	$(MAKE) -C fennel && chmod +x fennel/fennel

lua-readline:
	if [ ! - d lua-readline ]; then \
		echo "lua-readline directory not present" \
		exit 1 \
	fi

lua-readline/C-readline.o: lua-readline
	$(CC) -c lua-readline/C-readline.c -I /usr/include/lua5.3 -I /usr/include/readline/ -o lua-readline/C-readline.o

lua-readline/C-readline.a: lua-readline/C-readline.o
	ar -rc lua-readline/C-readline.a lua-readline/C-readline.o

clean:
	rm -f lua-readline/lua-readline{.o,.a}
	rm -rf fennel-static-readline 

.PHONY: clean
