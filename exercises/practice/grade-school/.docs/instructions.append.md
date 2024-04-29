# Instructions append

It isn't strictly necessary to model students as a separate object, you can use a convenient internal data structure as the requirements are quite simple (and as long as it doesn't leak out into the results).

~~~~exercism/note
This exercise has been slightly modified from the problem-specification, as it makes more sense to separate adding students and querying them in separate methods (vs. having one method doing both, which feels less Pharo/Smalltalk like).
~~~~
