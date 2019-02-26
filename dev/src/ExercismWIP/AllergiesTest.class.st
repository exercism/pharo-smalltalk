"
# Allergies

Given a person's allergy score, determine whether or not they're allergic to a given item, and their full list of allergies.

An allergy test produces a single numeric score which contains the
information about all the allergies the person has (that they were
tested for).

The list of items (and their value) that were tested are:

* eggs (1)
* peanuts (2)
* shellfish (4)
* strawberries (8)
* tomatoes (16)
* chocolate (32)
* pollen (64)
* cats (128)

So if Tom is allergic to peanuts and chocolate, he gets a score of 34.

Now, given just that score of 34, your program should be able to say:

- Whether Tom is allergic to any one of those allergens listed above.
- All the allergens Tom is allergic to.

Note: a given score may include allergens **not** listed above (i.e.
allergens that score 256, 512, 1024, etc.).  Your program should
ignore those components of the score.  For example, if the allergy
score is 257, your program should only report the eggs (1) allergy.

## Hint

TBD

"
Class {
	#name : #AllergiesTest,
	#superclass : #ExercismTest,
	#instVars : [
		'allergiesCalculator'
	],
	#category : #'ExercismWIP-Allergies'
}

{ #category : #config }
AllergiesTest class >> uuid [
	"Answer a unique id for this exercise"
	^'23f72dda-2b3f-0d00-a303-8a3409f0590c'
]

{ #category : #config }
AllergiesTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
AllergiesTest >> setUp [
	allergiesCalculator := Allergies new
]

{ #category : #test }
AllergiesTest >> testAllergicToAllergicToEggsInAdditionToOtherStuff [
	| result |

	result := allergiesCalculator allergicToScore: 5 .
	self assert: result equals: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('substance'->'eggs'); add: ('result'->true); yourself); at: 2 put: ((Dictionary new) add: ('substance'->'shellfish'); add: ('result'->true); yourself); at: 3 put: ((Dictionary new) add: ('substance'->'strawberries'); add: ('result'->false); yourself); yourself)
]

{ #category : #test }
AllergiesTest >> testAllergicToAllergicToStrawberriesButNotPeanuts [
	| result |

	result := allergiesCalculator allergicToScore: 9 .
	self assert: result equals: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('substance'->'eggs'); add: ('result'->true); yourself); at: 2 put: ((Dictionary new) add: ('substance'->'peanuts'); add: ('result'->false); yourself); at: 3 put: ((Dictionary new) add: ('substance'->'shellfish'); add: ('result'->false); yourself); at: 4 put: ((Dictionary new) add: ('substance'->'strawberries'); add: ('result'->true); yourself); yourself)
]

{ #category : #test }
AllergiesTest >> testAllergicToIsAllergicToEggs [
	| result |

	result := allergiesCalculator allergicToScore: 1 .
	self assert: result equals: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('substance'->'eggs'); add: ('result'->true); yourself); yourself)
]

{ #category : #test }
AllergiesTest >> testAllergicToNoAllergiesMeansNotAllergic [
	| result |

	result := allergiesCalculator allergicToScore: 0 .
	self assert: result equals: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('substance'->'peanuts'); add: ('result'->false); yourself); at: 2 put: ((Dictionary new) add: ('substance'->'cats'); add: ('result'->false); yourself); at: 3 put: ((Dictionary new) add: ('substance'->'strawberries'); add: ('result'->false); yourself); yourself)
]

{ #category : #test }
AllergiesTest >> testListAllergicToEggsAndPeanuts [
	| result |

	result := allergiesCalculator listScore: 3 .
	self assert: result equals: #('eggs' 'peanuts' )
]

{ #category : #test }
AllergiesTest >> testListAllergicToEverything [
	| result |

	result := allergiesCalculator listScore: 255 .
	self assert: result equals: #('eggs' 'peanuts' 'shellfish' 'strawberries' 'tomatoes' 'chocolate' 'pollen' 'cats' )
]

{ #category : #test }
AllergiesTest >> testListAllergicToJustEggs [
	| result |

	result := allergiesCalculator listScore: 1 .
	self assert: result equals: #('eggs' )
]

{ #category : #test }
AllergiesTest >> testListAllergicToJustPeanuts [
	| result |

	result := allergiesCalculator listScore: 2 .
	self assert: result equals: #('peanuts' )
]

{ #category : #test }
AllergiesTest >> testListAllergicToJustStrawberries [
	| result |

	result := allergiesCalculator listScore: 8 .
	self assert: result equals: #('strawberries' )
]

{ #category : #test }
AllergiesTest >> testListAllergicToLotsOfStuff [
	| result |

	result := allergiesCalculator listScore: 248 .
	self assert: result equals: #('strawberries' 'tomatoes' 'chocolate' 'pollen' 'cats' )
]

{ #category : #test }
AllergiesTest >> testListAllergicToMoreThanEggsButNotPeanuts [
	| result |

	result := allergiesCalculator listScore: 5 .
	self assert: result equals: #('eggs' 'shellfish' )
]

{ #category : #test }
AllergiesTest >> testListIgnoreNonAllergenScoreParts [
	| result |

	result := allergiesCalculator listScore: 509 .
	self assert: result equals: #('eggs' 'shellfish' 'strawberries' 'tomatoes' 'chocolate' 'pollen' 'cats' )
]

{ #category : #test }
AllergiesTest >> testListNoAllergiesAtAll [
	| result |

	result := allergiesCalculator listScore: 0 .
	self assert: result equals: #()
]
