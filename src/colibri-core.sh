#!/bin/sh

# **Colibri core** is a tool to *efficiently* search patterns in large plain-text corpora .
# Patterns are either n-grams or non-consecutive skipgrams/flexgrams. 

# Colibri Core uses an optimised compression to be able to hold more in memory.

# We start by downloading some text from the web, a tokenised copy of Plato's Republic.
# The tokenisation is important for colibri-core.

wget https://raw.githubusercontent.com/proycon/colibri-core/master/exp/republic.txt

# Then we *encode* it for colibri-core. This effectively compresses the data:

colibri-classencode republic.txt

# This produced a vocabulary/class file (cls) and the compressed data using that vocabulary:

ls -lh republic*

sleep 5

# Now we build a **pattern model**, counting all n-grams that occur at least twice, up to a maximum length of 10.

colibri-patternmodeller --datafile republic.colibri.dat --threshold 2 --maxlength 10 --unindexed --outputmodel republic.colibri.unindexedpatternmodel

# We can print and decode the pattern model to see the counts:

colibri-patternmodeller --inputmodel republic.colibri.unindexedpatternmodel --classfile republic.colibri.cls --print  > republic-output.tsv

column -t republic-output.tsv | head -n 20

sleep 5

# The above was a so-called **unindexed pattern model** (`-u`), it does not retain the exact positions where each pattern was found.
# An **indexed pattern model**, however, does so, at the expense of more memory:
# Let's build one and also count skipgrams:

colibri-patternmodeller --datafile republic.colibri.dat --threshold 2 --maxlength 10 --skipgrams --unindexed --outputmodel republic.colibri.indexedpatternmodel

# Let's view the results:

colibri-patternmodeller --inputmodel republic.colibri.indexedpatternmodel --classfile republic.colibri.cls --print  > republic-output-indexed.tsv

column -t republic-output-indexed.tsv | head -n 20

sleep 5

# We can also generate reports aggregating counts:

colibri-patternmodeller --inputmodel republic.colibri.indexedpatternmodel --report

sleep 5

# Or a histogram for the occurences:

colibri-patternmodeller --inputmodel republic.colibri.indexedpatternmodel --histogram | head -n 20

sleep 5

# Colibri Core contains way more functionality than shown in this demo, once patterns are extracted
# into an indexed model you can query the model and compute relations between patterns. 
# Check the documentation for more! There also is a Python binding to work with Colibri Core directly from Python.

# Visit <https://proycon.github.io/colibri-core> for more information.
