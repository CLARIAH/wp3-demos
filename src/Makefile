all: out/frog.cast out/ucto.cast out/python-frog.cast out/python-ucto.cast out/colibri-core.cast

out/%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@

