setup:
	@brew install rust
	@brew install hugo
	@cargo install obsidian-export
	@git clone git@github.com:consolelabs/content.git vault
	@mkdir -p ./content
	
setup-devbox:
	@if ! command -v devbox >/dev/null 2>&1; then curl -fsSL https://get.jetpack.io/devbox | bash; fi
	@devbox install
	@mkdir -p ./content

build:
	@obsidian-export --hard-linebreaks ./vault ./content
	@hugo -DEF --minify

run:
	@obsidian-export --hard-linebreaks ./vault ./content
	hugo -DEF server

watch-run:
	@rm -rf ./content
	@mkdir -p content
	@obsidian-export --hard-linebreaks ./vault ./content
	@./inotify.sh ./vault obsidian-export --hard-linebreaks ./vault ./content &
	@hugo -DEF server

build-target:
	@mkdir -p vault content
	@rsync -avh "$(path)" ./vault/ --delete
	@obsidian-export --hard-linebreaks ./vault/ ./content/
	@hugo -DEF --minify

run-target:
	@mkdir -p vault content
	@rsync -avh $(path) ./vault/ --delete
	@obsidian-export --hard-linebreaks ./vault/ ./content/
	@hugo -DEF server
