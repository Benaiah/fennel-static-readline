# This Makefile is supposed to be run outside of the docker container

fennel-static-http: Dockerfile fennel src/Lua-cURLv3/src $(wildcard src/*.fnl) $(wildcard src/*.lua) $(wildcard src/**/*.fnl) $(wildcard src/**/*.lua)
	docker build -t fennel-static-http .
	docker run --rm --entrypoint cat fennel-static-http /usr/src/fennel-static-http/fennel-static-http > fennel-static-http
	chmod +x fennel-static-http
	mkdir -p sizes
	du -h fennel-static-http > sizes/initial.txt
	strip fennel-static-http
	du -h fennel-static-http > sizes/stripped.txt

fennel-static-http.gz: fennel-static-http
	gzip -kf fennel-static-http
	du -h fennel-static-http.gz > sizes/gzipped.txt

fennel:
	git submodule init
	git submodule update

src/Lua-cURLv3/src:
	git submodule init
	git submodule update

clean:
	rm -f fennel-static-http{,.gz}
	$(MAKE) -C src clean
	$(MAKE) -C fennel clean

.PHONY: clean
