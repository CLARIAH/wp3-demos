#!/bin/sh

# Frog is a tool that integrates various NLP modules for Dutch

# Amongst these modules are for instance a tokeniser (ucto), a part of speech tagger,
# a lemmatiser, a named-entity recogniser, a dependency parser, and more...
# The core tool is designed to be invoked on the command line as we will show now.
# In this demo we assume Frog is already installed on your system.
# First we prepare a simple text file as input

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

sleep 2

# You don't need to run all modules; you can skip any you are not interested in. 
# This will improve over-all performance:

frog --skip=pnc input.txt > output2.tsv

# The TSV output format is limited. But Frog can also output to a more expressive format.
# It has built-in support for **FoLiA XML**. 
# FoLiA is a rich XML-based format for linguistic annotations.
# We use the `-X` parameter to output in this format:

frog --nostdout -X output.folia.xml input.txt

# Let's inspect a part of this XML output that shows the tokenised structure and **inline annotations**:

bat --line-range 65:+30 output.folia.xml

sleep 10
silent clear

# Now we look at another another part a bit further down where we see what FoLiA calls **span annotations**:

bat --line-range 297:+30 output.folia.xml
sleep 10

# We will come back to FoLiA multiple times throughout this demo.

silent clear

# First I want to introduce **ucto**.

# Ucto is the rule-based tokeniser used by Frog,
# but which you can also run independently.
# The rules are regular expressions, you can make your own configurations,
# for example for a specific language or use case

# Out-of-the-box ucto already supports various languages, not just dutch,
# we pass the `-L` parameter to specify the language, and set the `-v` flag to get verbose output:

ucto -Lnld input.txt

# Ucto too, can output FoLiA XML directly:

ucto -Lnld input.txt output2.folia.xml

bat --line-range 27:+33 output2.folia.xml
sleep 5
silent clear

# For both Frog and Ucto, Python bindings are available.
# They are called python-frog and python-ucto, respectively.
# This exposes the functionality from Frog and ucto to Python, 
# rather than through a command-line interface.

# We can install python-frog as follows (we suggest you make a virtual environment first)

pip install python-frog

# Because this is our first run, we first need to download the data (models) for Frog:

python -c "import frog; frog.installdata()"

# We prepared a small python script that does the same as our earlier command-line example:

bat frogexample.py
sleep 10

# Let's run it and look at the output:

python frogexample.py
sleep 10

# The python-ucto binding, i.e. for tokenisation, works in a very similar way:

pip install python-ucto
python -c "import ucto; ucto.installdata()"

# Here is a simple python script with ucto:

bat uctoexample.py
sleep 10

# Let's run it and look at the output:

python uctoexample.py
sleep 10

# Both python bindings also support FoLiA XML,
# they then returns results you can inspect with the **FoLiA library for Python** (aka foliapy).

# You can install this library as follows:

pip install folia

# We prepared the following Python script making use of both python-frog and foliapy:

bat frogexample_folia.py
sleep 10

# Let's run it and look at the output again:

python frogexample_folia.py
sleep 10
