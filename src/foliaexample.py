#!/usr/bin/env python3

from folia.main import Document, Word, Sentence, Entity

doc = Document(file="example.folia.xml")

# Visualize some of the output
for word in doc.words():
    assert isinstance(word, Word)
    print(word.text(), word.pos(), word.lemma())
print()

# Get an element by ID:
word = doc['input.txt.p.1.s.1.w.1']
assert str(word) == "Meneer"

# Get the next word
nextword = word.next(Word)

# Get the sentence(s) a word is part of
for sentence in word.ancestors(Sentence):
    print(word.id," is a word in sentence ", sentence.id)

# Find named named entities a particular word is part of 
for entity in nextword.findspans(Entity, set="http://ilk.uvt.nl/folia/sets/frog-ner-nl"):
    print(str(entity), " is an entity of type ", entity.cls)


