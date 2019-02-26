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

TBD

"
Class {
	#name : #LeapTest,
	#superclass : #ExercismTest,
	#instVars : [
		'leapCalculator'
	],
	#category : #'Exercism-Leap'
}

{ #category : #config }
LeapTest class >> core [
	"Answer a Boolean, true is this is a core exercise"
	
	^true
]

{ #category : #config }
LeapTest class >> difficulty [
	^1
]

{ #category : #helper }
LeapTest class >> followedBy [
	"If this is a core exercise, answer the next one that follows otherwise nil (if not a core exercise, or the last one)"
	
	^'ReverseString'
]

{ #category : #config }
LeapTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('booleans' 'conditionals' 'logic')
]

{ #category : #config }
LeapTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^HelloWorldTest  
]

{ #category : #config }
LeapTest class >> uuid [
	"Answer a unique id for this exercise"
	^'82b07f5c-119c-4250-8c07-a0a7e1a95458'
]

{ #category : #config }
LeapTest class >> version [
	"Generated from specification: 25 February 2019"
	^'1.6.0'
]

{ #category : #setup }
LeapTest >> setUp [
	leapCalculator := Leap new
]

{ #category : #test }
LeapTest >> testMisuseOfSelector [
	self verifySolution: leapCalculator class avoidsSelector: #isLeapYear
]

{ #category : #test }
LeapTest >> testYearDivisibleBy100NotDivisibleBy400InCommonYear [
	| result |

	result := leapCalculator leapYear: 2100 .
	self assert: result equals: false
]

{ #category : #test }
LeapTest >> testYearDivisibleBy200NotDivisibleBy400InCommonYear [
	| result |

	result := leapCalculator leapYear: 1800 .
	self assert: result equals: false
]

{ #category : #test }
LeapTest >> testYearDivisibleBy2NotDivisibleBy4InCommonYear [
	| result |

	result := leapCalculator leapYear: 1970 .
	self assert: result equals: false
]

{ #category : #test }
LeapTest >> testYearDivisibleBy400InLeapYear [
	| result |

	result := leapCalculator leapYear: 2000 .
	self assert: result equals: true
]

{ #category : #test }
LeapTest >> testYearDivisibleBy4NotDivisibleBy100InLeapYear [
	| result |

	result := leapCalculator leapYear: 1996 .
	self assert: result equals: true
]

{ #category : #test }
LeapTest >> testYearNotDivisibleBy4InCommonYear [
	| result |

	result := leapCalculator leapYear: 2015 .
	self assert: result equals: false
]
