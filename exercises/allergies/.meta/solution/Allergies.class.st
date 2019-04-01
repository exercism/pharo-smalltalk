"
This solution shows how Pharo can access bit sequences to solve this exercise. In this case, Pharo's 1 based indexing works well with an allergy list.
"
Class {
	#name : #Allergies,
	#superclass : #Object,
	#category : #'Exercism-Allergies'
}

{ #category : #config }
Allergies class >> allergyList [
	"Each item is a successive power of 2, so order is important"
	
	^ #('eggs' 'peanuts' 'shellfish' 'strawberries' 'tomatoes' 'chocolate' 'pollen' 'cats')
]

{ #category : #exercism }
Allergies >> allergicToItem: itemString forScore: anInteger [
	^ (anInteger bitAt: (self bitIndexFor: itemString)) = 1
]

{ #category : #exercism }
Allergies >> allergyListForScore: scoringInteger [
	^ (self class allergyList
		collectWithIndex: [ :item :index | 
			(scoringInteger bitAt: index) = 1
				ifTrue: [ item ]
				ifFalse: [ nil ] ]) reject: [ :item | item isNil ]
]

{ #category : #helper }
Allergies >> bitIndexFor: aString [
	^ self class allergyList
		indexOf: aString
		ifAbsent: [ ^ DomainError signal: 'invalid food item, ' , aString ]
]
