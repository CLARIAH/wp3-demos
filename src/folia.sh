#!/bin/sh

# Tools like Frog, ucto and varous others developed over the years, make use of the **FoLiA** format.
# FoLiA is an XML-based format for linguistic annotation.  It has been in use for over a decade.
# It is indended as an interchange format for language resources and a storage format for annotated corpora.

# The format comes with many practical tools to allow you to work with it.

# Let's first generate a FoLiA document using Frog, consisting of one dutch sentence:

echo "Meneer Jan Janssen wil deze zin automatisch analyseren." > input.txt
frog --nostdout -X example.folia.xml input.txt

# Let's inspect a part of this XML example that shows the tokenised structure:

bat --line-range 65:+30 example.folia.xml

# FoLiA keeps extensive provenance information on the tools that produced or edited a document:

bat --line-range 44:61 example.folia.xml

# In *FoLiA-tools* and *foliautils*, a broad collection of command line tools is available to work with FoLiA.
# These contain tools for simple analysis, conversion and querying.
# Let's install FoLiA tools:

pip install FoLiA-tools

# The validator is an important tool to check if a FoLiA document is valid FoLiA:

foliavalidator example.folia.xml

# A tool is available to convert to simple columned example (limited):

folia2columns -c id,text,lemma,pos example.folia.xml

# We can extract the text of a FoLiA document as follows:

folia2txt example.folia.xml

# Or convert it to HTML, which is good for presenting a visualisation to a user. 
# The HTML allows the user to mouse over tokens and see annotations.

folia2html example.folia.xml > example.html

# There are more converters in foliatools and foliautils, 
# such as a convertor for TEI to FoLiA, PageXML to FoLiA, ALTO to FoLiA, and more...

# There is a query language called FQL which allows you to query FoLiA documents:

foliaquery -q "SELECT pos IN w" example.folia.xml

# The most powerful way to interact with FoLiA is probably the FoLiA library.
# There is a FoLiA library for Python (foliapy), most often used,
# and there is also one for C++ (libfolia). 
# All of the aforementioned tooling, including Frog, builds on one of those libraries.

# Let's install the FoLiA library for Python first:

pip install folia

# Then take a look at the following script we prepared:

bat foliaexample.py
sleep 12

# Let's run this script:

python foliaexample.py

# There is more to FoLiA than shown in this short demo,
# please see <https://proycon.github.io/folia for more information.

# There is also a complete web-based annotation environment for FoLiA, called FLAT, see <https://github.com/proycon/flat>.


























