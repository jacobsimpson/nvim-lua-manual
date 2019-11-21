
default::
	rm -f book.min.*.css en.search-data.min.*.js en.search.min.*.js
	cd site && hugo -D

test::
	cd site && hugo server --minify --theme book --disableFastRender

