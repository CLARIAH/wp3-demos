#!/usr/bin/env python3

from frog import Frog, FrogOptions

# Instantiate the frog instance
frog = Frog(FrogOptions(parser=False))

# Pass data to Frog
results = frog.process("Meneer Jan Janssen wil deze zin automatisch analyseren.")

# Obtain the output, each result row will be a python dictionary containing all the fields
for result in results:
    assert isinstance(result, dict)
    print(result)
