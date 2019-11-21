
default::
	cd site && hugo -D

test::
	cd site && hugo server --minify --theme book --disableFastRender

