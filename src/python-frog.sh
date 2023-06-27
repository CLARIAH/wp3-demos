#!/bin/sh

# Frog, the NLP tool for Dutch, can be used directly from Python, 
# rather than through a command-line interface.

# This is done via its python binding `python-frog´.

# We can install python-frog as follows (you may want to ensure you are in a virtualenv first)

pip install python-frog

# Because this is our first run, we first need to download the data (models) for Frog:

python -c "import frog; frog.installdata()"

# We prepared a small python script that processes a single sentence:

bat frogexample.py
sleep 10

# Let's run it and look at the output:

python frogexample.py
sleep 10

# The Frog python binding also support FoLiA XML,
# it then returns results you can inspect with the **FoLiA library for Python** (aka foliapy).

# You can install this library as follows:

pip install folia

# We prepared the following Python script making use of both python-frog and foliapy:

bat frogexample_folia.py
sleep 10

# Let's run it and look at the output again:

python frogexample_folia.py
sleep 10

# Visit <https://github.com/proycon/python-frog> for more information.
