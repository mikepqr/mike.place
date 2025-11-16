.PHONY: deploy clean server

build: $(shell git ls-files)
	hugo
	touch $@

clean:
	rm -f build
	rm -rf public

server: clean
	hugo server --buildDrafts
