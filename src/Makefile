all: frog.gif ucto.gif python-frog.gif python-ucto.gif colibri-core.gif analiticcl.gif folia.gif

.PRECIOUS: %.cast
%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@


.PRECIOUS: %.gif
%.gif: %.cast
	agg --cols 149 --rows 40 --theme asciinema --font-size 16 --font-family "FiraMono Nerd Font,Fira Mono Nerd Font,FuraMono Nerd Font" $< $@  

demo.gif: frog.gif python-frog.gif ucto.gif python-ucto.gif folia.gif colibri-core.gif analiticcl.gif
	gifsicle --colors 256 --careful frog.gif python-frog.gif ucto.gif python-ucto.gif folia.gif colibri-core.gif analiticcl.gif > $@

clean:
	rm *.gif *.cast *.ts

