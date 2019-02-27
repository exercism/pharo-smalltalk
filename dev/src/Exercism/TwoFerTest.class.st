"
# Two Fer

`Two-fer` or `2-fer` is short for two for one. One for you and one for me.

Given a name, return a string with the message:

```text
One for X, one for me.
```

Where X is the given name.

However, if the name is missing, return the string:

```text
One for you, one for me.
```

Here are some examples:

|Name    | String to return 
|:------:|:-----------------: 
|Alice   | One for Alice, one for me. 
|Bob     | One for Bob, one for me.
|        | One for you, one for me.
|Zaphod  | One for Zaphod, one for me.

## Hint

In Pharo, classes are objects that can have instance and class methods, however unlike HelloWorld the tests for TwoFer have been written to call instance methods. Typically class methods are used for constructing new objects (like a contructor in other languages).
"
Class {
	#name : #TwoFerTest,
	#superclass : #ExercismTest,
	#instVars : [
		'twoFer'
	],
	#category : #'Exercism-TwoFer'
}

{ #category : #config }
TwoFerTest class >> difficulty [
	^1
]

{ #category : #config }
TwoFerTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('strings' 'text-formatting' 'refactoring')
]

{ #category : #config }
TwoFerTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^HelloWorldTest 
]

{ #category : #config }
TwoFerTest class >> uuid [
	"Answer a unique id for this exercise"
	^'9806fcc0-8505-4012-bd64-3f7468014df5'
]

{ #category : #config }
TwoFerTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^'1.2.0'
]

{ #category : #setup }
TwoFerTest >> setUp [
	twoFer := TwoFer new.
]

{ #category : #tests }
TwoFerTest >> testANameGiven [
	self assert: (twoFer who: 'Alice') equals: 'One for Alice, one for me.'
]

{ #category : #tests }
TwoFerTest >> testAnotherNameGiven [
	self assert: (twoFer who: 'Bob') equals: 'One for Bob, one for me.' 
]

{ #category : #tests }
TwoFerTest >> testNoNameGiven [
	self assert: twoFer who equals: 'One for you, one for me.' 
	
]
