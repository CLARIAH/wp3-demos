all: out/frog.gif out/ucto.gif out/python-frog.gif out/python-ucto.gif out/colibri-core.gif out/analiticcl.gif out/folia.gif


.PRECIOUS: out/%.cast
out/%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@

.PRECIOUS: out/%.gif
out/%.gif: out/%.cast
	agg --cols 149 --rows 40 --theme asciinema --font-size 16 --font-family "FiraMono Nerd Font,Fira Mono Nerd Font,FuraMono Nerd Font" $< $@  

out/%.ts: out/%.gif
	ffmpeg -i $< -f mpegts $@

clean:
	rm *.gif *.cast *.ts

