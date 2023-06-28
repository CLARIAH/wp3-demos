all: out/frog.gif out/ucto.gif out/python-frog.gif out/python-ucto.gif out/colibri-core.gif out/analiticcl.gif out/folia.gif


out/%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@

%.cast: %.sh
	asciinema-rec_script ./$<
	mv -f $<.cast $@

%.gif: %.cast
out/%.gif: out/%.cast
	cp %< tmp.cast #agg removes the input so we make a copy first
	agg --cols 149 --rows 40 --theme asciinema --font-size 16 --font-family "FiraMono Nerd Font,Fira Mono Nerd Font,FuraMono Nerd Font" tmp.cast $@  

%.ts: %.gif
out/%.ts: out/%.gif
	ffmpeg -i $< -f mpegts $@

clean:
	rm *.gif *.cast

covers:
	cd covers && make all

video:
	ffmpeg -i "concat:covers/frog.ts|frog.ts" -f mpegts out.mp4

