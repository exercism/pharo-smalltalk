"
This solution is pretty straight forward.
"
Class {
	#name : #TwelveDays,
	#superclass : #Object,
	#category : #'Exercism-TwelveDays'
}

{ #category : #gifts }
TwelveDays >> gifts [
	^ #(
	'a Partridge in a Pear Tree'
	'two Turtle Doves'
	'three French Hens'
	'four Calling Birds'
	'five Gold Rings'
	'six Geese-a-Laying' 
	'seven Swans-a-Swimming' 
	'eight Maids-a-Milking' 
	'nine Ladies Dancing'
	'ten Lords-a-Leaping' 
	'eleven Pipers Piping' 
	'twelve Drummers Drumming' )
]

{ #category : #gifts }
TwelveDays >> giftsOnDay: anInteger [
	^ anInteger = 1
		ifTrue: [ self gifts first ]
		ifFalse: [
			| gifts |
			
			gifts := (self gifts copyFrom: 1 to: anInteger) reverse.
			(gifts allButLast inject: '' into: [ :str :each | str , each , ', ' ]) , 'and ', gifts last ]
]

{ #category : #converting }
TwelveDays >> ordinal: anInteger [
	"This would ideally be an extension on Integer or something on those lines"
	^ #(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth) at: anInteger 
]

{ #category : #reciting }
TwelveDays >> reciteStartVerse: start endVerse: end [
	^ (start to: end) collect: [ :each | self verse: each ]
]

{ #category : #reciting }
TwelveDays >> verse: anInteger [
	^ 'On the {1} day of Christmas my true love gave to me: {2}.'
		format: { self ordinal: anInteger. self giftsOnDay: anInteger }
]
