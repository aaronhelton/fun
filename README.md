fun
===

Things I do for fun.

===

mgen.rb is a quick sonnet generator.  It generates sonnets in the style of Shakespeare using Markov chains.

The text file included, pg1041.romp.txt, contains all of Shakespeare's sonnets.  

You'll need marky_markov to run it: gem install marky_markov

nouns.txt is a plain text list of English language nouns, one per line, pulled from a list of collective nouns and the animals/people/things they refer to.  Use the list however you like.  Source: http://en.wikipedia.org/wiki/List_of_collective_nouns_in_English

adjectives.txt is a plain text list of simple English language adjectives, one per line.  Once again, use it how you like.  For instance, you could combine an adjective with a noun to get something like "important gorillas".  Source: http://simple.wikipedia.org/wiki/Wikipedia:List_of_simple_adjectives


namegen.rb is a condensed version of a script I found in the wild.  It takes word lists as input and spits out random recombinations of words using basic Markov chains.  I am using it with lists of place names and other lists located in my wordlists repo to make regionally flavored place and people names for RPGs.  It might also be useful for making pronounceable passwords.
