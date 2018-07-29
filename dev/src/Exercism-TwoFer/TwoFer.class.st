"
# Two Fer

`Two-fer` or `2-fer` is short for two for one. One for you and one for me.

```text
""One for X, one for me.""
```

When X is a name or ""you"".

If the given name is ""Alice"", the result should be ""One for Alice, one for me.""
If no name is given, the result should be ""One for you, one for me.""


* * * *

For installation and learning resources, refer to the
[exercism help page](http://exercism.io/languages/pharo).

The provided tests can be run directly from the test class or the Test 
Runner tool from the World menu `ctrl + OU` (MacOS `cmd + OU`).

## Source

This is an exercise to introduce users to basic programming constructs, just after Hello World. [https://en.wikipedia.org/wiki/Two-fer](https://en.wikipedia.org/wiki/Two-fer)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
"
Class {
	#name : #TwoFer,
	#superclass : #Object,
	#category : #'Exercism-TwoFer'
}

{ #category : #exercism }
TwoFer >> who [
	^ 'One for you, one for me.'
]

{ #category : #exercism }
TwoFer >> who: aString [ 
	^ 'One for ', aString, ', one for me.'
]
