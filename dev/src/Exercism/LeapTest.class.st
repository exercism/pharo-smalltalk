"
# Leap

Given a year, report if it is a leap year.

The tricky thing here is that a leap year in the Gregorian calendar occurs:

```text
on every year that is evenly divisible by 4
  except every year that is evenly divisible by 100
    unless the year is also evenly divisible by 400
```

For example, 1997 is not a leap year, but 1996 is.  1900 is not a leap
year, but 2000 is.

## Notes

Though our exercise adopts some very simple rules, there is more to
learn!

For a delightful, four minute explanation of the whole leap year
phenomenon, go watch [this youtube video][video].

[video]: http://www.youtube.com/watch?v=xX96xng7sAE

## Hint

Although Pharo provides a method in the standard library that does this, try and implement it from first principles without looking.

If you are stuck, look at how boolean operators are actually defined as messages. Study how ""and:"" and ""or:"" are implented in the classes True and False, and then use the context menu item - senders of... to see how other parts of Pharo use them.

"
Class {
	#name : #LeapTest,
	#superclass : #ExercismTest,
	#instVars : [
		'leapYearCalculator'
	],
	#category : #'Exercism-Leap'
}

{ #category : #meta }
LeapTest class >> core [
	"Answer a Boolean, true is this is a core exercise"
	
	^true
]

{ #category : #meta }
LeapTest class >> difficulty [
	^1
]

{ #category : #config }
LeapTest class >> followedBy [
	"If this is a core exercise, answer the next one that follows otherwise nil (if not a core exercise, or the last one)"
	
	^'ReverseString'
]

{ #category : #meta }
LeapTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('booleans' 'conditionals' 'logic')
]

{ #category : #config }
LeapTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^HelloWorldTest  
]

{ #category : #meta }
LeapTest class >> uuid [
	"Answer a unique id for this exercise"
	^'82b07f5c-119c-4250-8c07-a0a7e1a95458'
]

{ #category : #config }
LeapTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^'1.4.0'
]

{ #category : #setup }
LeapTest >> setUp [
	leapYearCalculator := Leap new
]

{ #category : #testing }
LeapTest >> testYearIsDivisibleBy100NotDivisibleBy400 [
	self deny: (leapYearCalculator isLeapYear: 2100)
]

{ #category : #testing }
LeapTest >> testYearIsDivisibleBy400 [
	self assert: (leapYearCalculator isLeapYear: 2000)
]

{ #category : #testing }
LeapTest >> testYearIsDivisibleBy4NotDivisibleBy100 [
	self assert: (leapYearCalculator isLeapYear: 1996)
]

{ #category : #testing }
LeapTest >> testYearNotDivisibleBy4 [
	self deny: (leapYearCalculator isLeapYear: 2015)
]
