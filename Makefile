

OPTS=-t coffeeify --extension=.coffee

all: built_javascripts/web.js built_javascripts/worker.js

built_javascripts:
	mkdir -p built_javascripts

built_javascripts/web.js: built_javascripts
	./node_modules/.bin/browserify $(OPTS) javascripts/web.coffee -o built_javascripts/web.js

built_javascripts/worker.js: built_javascripts
	./node_modules/.bin/browserify $(OPTS) javascripts/worker.coffee -o built_javascripts/worker.js

watch_web: built_javascripts
	./node_modules/.bin/watchify $(OPTS) javascripts/web.coffee -o built_javascripts/web.js

watch_worker: built_javascripts
	./node_modules/.bin/watchify $(OPTS) javascripts/worker.coffee -o built_javascripts/worker.js

