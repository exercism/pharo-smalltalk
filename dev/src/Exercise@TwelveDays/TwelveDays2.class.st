"
Mentor notes:

- this alternate solution demonstrates use of `SequenceableCollection>>#joinUsing:last:`, connecting a series of strings with a common separator while changing the separator for the last string.
"
Class {
	#name : #TwelveDays2,
	#superclass : #Object,
	#category : #'Exercise@TwelveDays-Solution2'
}

{ #category : #converting }
TwelveDays2 >> dayName: anInteger [
	"This would ideally be an extension on Integer or something on those lines"
	^ #(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth) at: anInteger
]

{ #category : #reciting }
TwelveDays2 >> getVerse: anInteger [ 
	| elements |
	elements := (self verses first: anInteger) reverse.
	^ 'On the ' , (self dayName: anInteger)
		, ' day of Christmas my true love gave to me: '
		, (elements joinUsing: ', ' last: ', and ') , '.'
]

{ #category : #reciting }
TwelveDays2 >> reciteStartVerse: start endVerse: end [
	^ (start to: end) collect: [ :each | self getVerse: each ]
]

{ #category : #reciting }
TwelveDays2 >> verses [
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
