FROM alpine:latest

RUN apk add bat frog util-linux-misc asciinema git make vim bash python3 py3-pip py3-wheel py3-lxml build-base autoconf-archive autoconf automake libtool bzip2-dev &&\
    mkdir -p /data /usr/src/ && cd /usr/src/ &&\
    git clone https://git.sr.ht/~proycon/asciinema-rec_script &&\
    ln -s /usr/src/asciinema-rec_script/bin/asciinema-rec_script /usr/bin/ &&\
    git clone https://github.com/proycon/colibri-core/ &&\
    cd colibri-core && bash bootstrap && ./configure --prefix=/usr && make && make install &&\
    cd /

COPY . /data

#no pager
ENV BAT_PAGER=cat

WORKDIR /data
VOLUME /data/out

ENTRYPOINT ["make"]
