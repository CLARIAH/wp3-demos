#!/bin/sh
if ! command -v asciinema; then
    echo "asciinema is not installed, please install it" >&2
    exit 2
fi
while : ; do
    clear
    asciinema play frog.cast
    clear
    asciinema play python-frog.cast
    clear
    asciinema play ucto.cast
    clear
    asciinema play python-ucto.cast
    clear
    asciinema play colibri-core.cast
    clear
    asciinema play analiticcl.cast
done
