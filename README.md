# CLARIAH WP3 Demos

This repository contains some screencast demos for a subset of software
developed in CLARIAH WP3. Furthermore it contains the sources to generate these
screencasts.

## Demos

### Frog

![Frog demo](frog.gif)

### Python-frog

![Python-frog demo](python-frog.gif)

### Ucto

![Ucto demo](ucto.gif)

### Python-ucto

![Python-ucto demo](python-ucto.gif)

### Colibri Core

![Colibri Core demo](colibri-core.gif)

### Analiticcl

![Analiticcl demo](analiticcl.gif)


## Build all the demos from source

```
$ cd src/
$ docker build -t wp3-demos .
$ docker run --rm -i -t -v .:/data/ wp3-demos
```


