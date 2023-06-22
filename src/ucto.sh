#!/bin/sh

# Ucto is a rule-based tokeniser.
# It is integrated in Frog, but can also run independently.

# The rules are regular expressions, you can make your own configurations,
# for example for a specific language or use case

# Out-of-the-box ucto already supports various languages, not just dutch.
# The list of languages will be outputted if you didn't specify one yet:

ucto

# Let's prepare a simple sentence as input for the tokeniser:

echo "To be, or not to be, that's the question." > tokinput.txt

# Now we will pass it to ucto along with `-L` parameter to specify the language,

ucto -L eng tokinput.txt

# For more verbose output, we can pass the `-v` flag:

ucto -v -L eng tokinput.txt

# Ucto can also output to a more expressive XML format called **FoLiA**..

ucto -L eng input.txt tokoutput.folia.xml

# Let's inspect a part of this XML output that shows the tokenised structure:

bat --line-range 27:+33 tokoutput.folia.xml
sleep 5
silent clear
