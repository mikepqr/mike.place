.PHONY: deploy clean server

deploy: build
	hugo deploy
	# Do this manually because you can't set hugo's
	# cloudFrontDistributionID config variable from the environment
	aws cloudfront create-invalidation --distribution-id=${AWS_CLOUDFRONT_DISTRIBUTION_ID} --paths "/*"

build: $(shell git ls-files)
	hugo
	touch $@

clean:
	rm -f build
	rm -rf public

server: clean
	hugo server --buildDrafts
