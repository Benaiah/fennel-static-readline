# This Makefile is supposed to be run within the docker container

fennel-static-http: lua-readline/lua-readline.a
	CC_OPTS="-static -no-pie" fennel --compile-binary \
		./fennel/src/launcher.fnl fennel-static-readline \
		/usr/lib/lua5.3/liblua.a /usr/include/lua5.3 \
		--native-module lua-readline/lua-readline.a \
		--native-library /usr/lib/libreadline.a \
		--native-library /usr/lib/libhistory.a \
		--native-library /usr/lib/libncursesw.a

lua-readline:
	if [ ! - d lua-readline ]; then \
		echo "lua-readline directory not present" \
		exit 1 \
	fi

lua-readline/lua-readline.o: lua-readline
	$(CC) -c lua-readline/C-readline.c -I /usr/include/lua5.3 -I /usr/include/readline/ -o lua-readline/lua-readline.o

lua-readline/lua-readline.a: lua-readline/lua-readline.o
	ar -rc lua-readline/lua-readline.a lua-readline/lua-readline.o

clean:
	rm -f lua-readline/lua-readline{.o,.a}
	rm -rf fennel-static-readline 

.PHONY: clean
