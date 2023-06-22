FROM alpine:latest

RUN apk add bat frog util-linux-misc asciinema git make vim bash python3 py3-pip py3-wheel py3-lxml &&\
    mkdir -p /data /usr/src/ && cd /usr/src/ &&\
    git clone https://git.sr.ht/~proycon/asciinema-rec_script &&\
    ln -s /usr/src/asciinema-rec_script/bin/asciinema-rec_script /usr/bin/ &&\
    cd /

COPY src /data

#no pager
ENV BAT_PAGER=cat

WORKDIR /data
VOLUME /data/out

ENTRYPOINT ["make"]
