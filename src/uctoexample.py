#!/usr/bin/env python3

import ucto

# Instantiate the tokenizer 
tokenizer = ucto.Tokenizer("tokconfig-eng")

#pass the text
tokenizer.process("To be, or not to be, that's the question.")

#read the results from the tokenizer
for token in tokenizer:
    print(token)
    
#the API also exposes methods like token.isendofsentence(), token.nospace(), and attributes like token.type
