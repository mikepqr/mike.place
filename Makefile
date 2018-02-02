clean:
	rm -rf public

build: clean
	hugo

server:
	hugo server -D

deploy: build
	aws s3 sync --exclude '*.swp' --delete public s3://mike.place
	aws cloudfront create-invalidation --distribution-id=${AWS_CLOUDFRONT_DISTRIBUTION_ID} --paths "/*"
