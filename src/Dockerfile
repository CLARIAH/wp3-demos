FROM alpine:latest

RUN apk add bat frog util-linux-misc asciinema git make vim bash python3 py3-pip py3-wheel py3-lxml build-base autoconf-archive autoconf automake libtool bzip2-dev rust cargo font-fira-mono-nerd figlet &&\
    mkdir -p /data /usr/src/ && cd /usr/src/ &&\
    git clone https://git.sr.ht/~proycon/asciinema-rec_script &&\
    ln -s /usr/src/asciinema-rec_script/bin/asciinema-rec_script /usr/bin/ &&\
    git clone https://github.com/proycon/colibri-core/ &&\
    cd colibri-core && bash bootstrap && ./configure --prefix=/usr && make && make install &&\
    cargo install --root /usr/ analiticcl &&\
    cargo install --root /usr/ --git https://github.com/asciinema/agg &&\
    cd /

COPY . /data
COPY fonts /usr/share/fonts/noto-emoji


#no pager
ENV BAT_PAGER=cat

WORKDIR /data
VOLUME /data/out

ENTRYPOINT ["make"]
