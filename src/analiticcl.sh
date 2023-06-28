#!/bin/sh

silent figlet -c Analiticcl
silent echo
silent echo "  https://github.com/proycon/analiticcl"

# Analiticcl is an approximate string matching system.
# It can be used  for spelling correction or text normalisation,
# (such as post-OCR correction or post-HTR correction). 

# Analiticcl takes an alphabet file and a lexicon file against which matches are made.
# Let's download two examples for those.

wget https://raw.githubusercontent.com/proycon/analiticcl/master/examples/simple.alphabet.tsv
wget https://raw.githubusercontent.com/proycon/analiticcl/master/examples/eng.aspell.lexicon

# The alphabet file defines the alphabet, 
# characters on the same line are considered identical for purposes of matching:

bat  simple.alphabet.tsv

# The lexicon just contains word forms, but may optionally also include a frequency score:

bat --line-range 411:+25 eng.aspell.lexicon

# Let's prepare some input for the system, a few misspelled words, one on each line:

echo -e "seperate\napparant\nacommodate\nbeleive" > input.txt

# Now we ask analiticcl to correct those using the provided lexicon:

analiticcl query --lexicon eng.aspell.lexicon --alphabet simple.alphabet.tsv < input.txt

# You see that for each input, analiticcl returned a set of variants, with a confidence score.

# We can also return this in a simple JSON format:

analiticcl query --lexicon eng.aspell.lexicon --alphabet simple.alphabet.tsv --json < input.txt > output.json

bat output.json
sleep 10

# The innovative feature of analiticcl is the speed at which it can compute these comparisons,
# it uses *anagram hashing* as a heuristic and is much faster
# than computing levenshtein distance on all candidate pairs individually.

# We can have analiticcl search and correct running text. Let's prepare some input and run it:

echo -e "Can you please acommodate us with seperate beds?" > input2.txt

analiticcl search --lexicon eng.aspell.lexicon --alphabet simple.alphabet.tsv < input2.txt

sleep 10

# There is way more to analiticcl than shown in this limited demo.
# * There is a wealth of configurate parameters to tweak the search behaviour
# * Instead of lexicons, you may supply (multiple) pre-computed variant lists, analiticcl can generate such variant lists for you as well.
# * You may pass a list of character confusibles
# * You can pass context rules and do even do rudimentary (entity) tagging with those.
# * A simple n-gram language model may be included.

# See <https://github.com/proycon/analiticcl> for more information.

