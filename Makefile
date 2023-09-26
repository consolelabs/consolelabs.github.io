setup:
	brew install rust && \
	brew install hugo && \
	cargo install obsidian-export && \
	if [ ! -d "./vault" ]; then git clone git@github.com:consolelabs/content.git vault; \
	else pushd vault && git pull && popd; fi && \
	mkdir -p ./content

build:
	pushd vault && \
	git pull && \
	popd && \
	obsidian-export ./vault ./content && \
	hugo --minify

run:
	hugo server

run-target:
	mkdir -p vault content && \
	rsync -avh $(path) ./vault/ --delete && \
	obsidian-export ./vault/ ./content/ && \
	hugo server
