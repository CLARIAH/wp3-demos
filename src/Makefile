all: out/frog.cast out/ucto.cast out/python-frog.cast out/python-ucto.cast

out/%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@

