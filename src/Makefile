all: out/frog.cast out/ucto.cast out/python-frog.cast out/python-ucto.cast out/colibri-core.cast out/analiticcl.cast out/folia.cast

out/%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@

