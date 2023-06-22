#!/bin/sh

# Ucto, the tokenizer, can be used directly from Python,
# via its python binding `python-ucto´
# This exposes the functionality of Ucto via Python, 

# rather than through a command-line interface.

# We can install python-ucto as follows (you may want to ensure you are in a virtualenv first)

pip install python-ucto
python -c "import ucto; ucto.installdata()"

# Here is a simple python script with ucto:

bat uctoexample.py
sleep 10

# Let's run it and look at the output:

python uctoexample.py
sleep 10

