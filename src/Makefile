all: out/frog.gif out/ucto.gif out/python-frog.gif out/python-ucto.gif out/colibri-core.gif out/analiticcl.gif out/folia.gif

out/%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@

out/%.gif: out/%.cast
	agg --cols 150 --rows 40 --theme asciinema --font-family "FiraMono Nerd Font,Fira Mono Nerd Font,FuraMono Nerd Font" $< $@  

clean:
	rm *.cast
	rm *.gif
