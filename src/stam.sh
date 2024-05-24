#!/bin/sh

silent figlet -c STAM \& STAM-tools
silent echo
silent echo "  https://annotation.github.io/stam"
silent echo "  https://github.com/annotation/stam-tools"

# STAM is a data model for stand-off annotation on text.
# It comes with practical tooling to deal with annotations,
# such as programming libraries for Rust and Python, as well a set of command-line tools.
# This demo will show the latter. See https://annotation.github.io/stam for more.

# First we install stam-tools using Rust's package manager `cargo`:

cargo install stam-tools

# Let's create a small text file to annotate

echo "I have no special talent. I am only passionately curious. -- Albert Einstein" > smallquote.txt

# We can now add this resource to a new STAM model (called an annotation store):

stam init --resource smallquote.txt demo.store.stam.json

# There is a variety of ways in which you can add annotations to this store.
# The most powerful means is via a STAMQL `ADD` query
# (documented at https://github.com/annotation/stam/tree/master/extensions/stam-query#add-query)

stam annotate --query 'ADD ANNOTATION WITH DATA "my-vocab" "type" "sentence"; ID "sentence1"; TARGET ?x { SELECT TEXT ?x WHERE RESOURCE "smallquote.txt" OFFSET 0 25; }' demo.store.stam.json

# In the above query we annotated the first sentence in our resource (char offset 0-25)
# as being of `type` (*datakey*), `sentence` (*datavalue*), in some 
# fictitious vocabulary (*annotation dataset*) we call "my-vocab".

# Having made an annotation, we can query for it using STAMQL. This will produce simple TSV output.

stam query --query 'SELECT ANNOTATION WHERE DATA "my-vocab" "type" = "sentence";' demo.store.stam.json > output.tsv

column -s "	" -t output.tsv


# More useful is to visualise the annotation in a textual context.
# We can output such visualisations either as HTML output (richer) or as ANSI text
# and again use a query to obtain the data.
# The first query determines the *primary context*, subsequent queries determine the *highlights*:

stam view --format ansi --query 'SELECT RESOURCE ?res'  --query '@VALUETAG SELECT ANNOTATION ?sentence WHERE RESOURCE ?res; DATA "my-vocab" "type" = "sentence";' demo.store.stam.json

# There are more formats in which we can export data by changing the `--format` parameter. 
# We can for example query results as STAM JSON (wrapped in a result object), which is pretty verbose
# and corresponds largely to how it is stored in the JSON file:

stam query --format json --query 'SELECT ANNOTATION WHERE DATA "my-vocab" "type" = "sentence";'  demo.store.stam.json | jq

# We can also convert our STAM data to the W3C Web Annotation model,
# which effectively turns it into linked data. The following produces JSON-LD:

stam query --format w3anno --query 'SELECT ANNOTATION ?annotation WHERE DATA "my-vocab" "type" = "sentence";' demo.store.stam.json | jq

# Getting data in and out of STAM in multiple ways is one of the cornerstones
# of STAM. It seeks to complement existing serialisations rather than replace them.

# For example, if you already have stand-off annotations in some arbitrary TSV or CSV format,
# it is relatively easy to import them into STAM.
# Let's create some external TSV data to annotate the second sentence:

echo "26	57	my-vocab	type	sentence" > annotations.tsv

# Now we import this data into STAM, we have to tell the importer our column configuration via a parameter,
# or we could have included it as a TSV header on the first line. We also tell it what resource it all pertains to.
# That too, we could have put in a column in the TSV itself.

stam import --no-header --inputfile annotations.tsv --resource smallquote.txt --columns BeginOffset,EndOffset,AnnotationDataSet,DataKey,DataValue demo.store.stam.json


# Repeating the same query to look at the result: 

stam view --format ansi --query 'SELECT RESOURCE ?res' --query '@VALUETAG SELECT ANNOTATION ?sentence WHERE RESOURCE ?res; DATA "my-vocab" "type" = "sentence";' demo.store.stam.json

# The TSV import is fairly clever, you can use it to do simple text matching.
# Let's annotate "Albert Einstein" as a person.

echo "Albert Einstein	my-vocab	type	person" > annotations2.tsv

stam import --no-header --inputfile annotations2.tsv --resource smallquote.txt --columns Text,AnnotationDataSet,DataKey,DataValue demo.store.stam.json

# Adapting the view query a bit so it will show all types: 

stam view --format ansi --query 'SELECT RESOURCE ?res' --query '@VALUETAG SELECT ANNOTATION ?type WHERE RESOURCE ?res; DATA "my-vocab" "type";' demo.store.stam.json

# For more advanced textual matching, we have `stam tag`. 
# In an external configuration file, this holds a set of regular expressions 
# and associates annotation data with each.

# Let's download some simple tokenisation rules:

curl https://raw.githubusercontent.com/knaw-huc/stam-experiments/main/config/stam-tag/simpletagger.tsv | tee simpletagger.tsv | column -s "	" -t

# and run a tagger using those on our data:

stam tag --rules simpletagger.tsv demo.store.stam.json

# Let's look at what we have now: 

stam view --format ansi --query 'SELECT RESOURCE ?res' --query '@VALUETAG SELECT ANNOTATION ?type WHERE RESOURCE ?res; DATA "my-vocab" "type";' --query '@VALUETAG SELECT ANNOTATION ?tokentype WHERE RESOURCE ?res; DATA "simpletokens" "type";' demo.store.stam.json

# We have a few overlapping annotations now; sentences and tokens.
# This allows us to formulate more powerful queries that exploit spatial relationships between annotations.
# Let's for example find all the tokens in the first sentence:

stam query --query 'SELECT ANNOTATION ?sentence WHERE ID "sentence1"; { SELECT ANNOTATION ?token WHERE RELATION ?sentence EMBEDS; DATA "simpletokens" "type"; }' demo.store.stam.json > output2.tsv

column -s "	" -t output2.tsv
