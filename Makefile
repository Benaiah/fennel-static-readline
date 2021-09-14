# This Makefile is supposed to be run outside of the docker container

fennel-static-readline: Dockerfile fennel src/lua-readline $(wildcard src/*.fnl) $(wildcard src/*.lua) $(wildcard src/**/*.fnl) $(wildcard src/**/*.lua)
	docker build -t fennel-static-readline .
	docker run --rm --entrypoint cat fennel-static-readline /usr/src/fennel-static-readline/fennel-static-readline > fennel-static-readline
	chmod +x fennel-static-readline
	mkdir -p sizes
	du -h fennel-static-readline > sizes/initial.txt
	strip fennel-static-readline
	du -h fennel-static-readline > sizes/stripped.txt

fennel-static-readline.gz: fennel-static-readline
	gzip -kf fennel-static-readline
	du -h fennel-static-readline.gz > sizes/gzipped.txt

fennel:
	git submodule init
	git submodule update

src/lua-readline:
	rm -rf src/lua-readline && curl https://pjb.com.au/comp/lua/readline-3.0.tar.gz | tar xz && mv -f readline-3.0 src/lua-readline

clean:
	rm -rf src/lua-readline
	rm -f fennel-static-readline{,.gz}
	$(MAKE) -C src clean
	$(MAKE) -C fennel clean

.PHONY: clean
