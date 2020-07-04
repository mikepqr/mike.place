deploy: build
	hugo deploy
	# Do this manually because you can't set hugo's
	# cloudFrontDistributionID config variable from the environment
	aws cloudfront create-invalidation --distribution-id=${AWS_CLOUDFRONT_DISTRIBUTION_ID} --paths "/*"

clean:
	rm -rf public

build: clean
	hugo

server: clean
	hugo server -D
