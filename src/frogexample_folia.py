#!/usr/bin/env python3

from frog import Frog, FrogOptions
from folia.main import Document, Word  #this is the FoLiA library

# Instantiate the frog instance. Set `xmlout` for FoLiA.
frog = Frog(FrogOptions(parser=False, xmlout=True))

# Pass the data to Frog, this now returns a folia `Document` instance.
doc = frog.process("Meneer Jan Janssen wil deze zin automatisch analyseren.")
assert isinstance(doc, Document)

# Visualize some of the output
for word in doc.words():
    assert isinstance(word, Word)
    print(word.text(), word.pos(), word.lemma())
