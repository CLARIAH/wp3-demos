#!/bin/sh

# Frog is a tool that integrates various NLP modules for Dutch

# Amongst these modules are for instance a tokeniser (ucto), a part of speech tagger,
# a lemmatiser, a named-entity recogniser, a dependency parser, and more...
# The core tool is designed to be invoked on the command line as we will show now.

# In this demo we assume Frog is already installed on your system.

# First we prepare a simple text file as input:

echo "Meneer Jan Janssen wil deze zin automatisch analyseren." > input.txt

# Then we invoke Frog to process it, with all available modules. This may take a while.

frog input.txt > output.tsv


# Let's inspect our results, they are in a simple tab-separated format: 

column -t output.tsv

# We see the following columns in the above output:
# 1. the token number
# 2. the text form
# 3. the lemma
# 4. the morphological analysis, 
# 5. the part-of-speech tag in the CGN tagset
# 6. an associated confidence value for PoS
# 7. Named entity recognition (BIO tagging)
# 8. Shallow syntactic parsing  / chunking
# 9. Dependency relation (points to a token number) 
# 10. Dependency relation 

# You don't need to run all modules; you can skip any you are not interested in:

frog --skip=pnc input.txt > output2.tsv

# The TSV output format is limited. 
# Frog can also output to a more expressive format: **FoLiA XML**.
# This is a rich XML-based format for linguistic annotations.
# We use the `-X` parameter to output in this format:

frog --nostdout -X output.folia.xml input.txt

# Let's inspect a part of this XML output that shows the tokenised structure:

bat --line-range 65:+30 output.folia.xml

sleep 10

# There is way more to Frog than shown in this limited demo.
# See <https://github.com/LanguageMachines/frog> for more information.

