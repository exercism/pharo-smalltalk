Class {
	#name : #TwelveDays,
	#superclass : #Object,
	#category : #'ExercismWIP-TwelveDays'
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
	"This would ideally be an extenssion on Integer or something on those lines"
	^ #(first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth) at: anInteger 
]

{ #category : #reciting }
TwelveDays >> reciteStartVerse: anInteger endVerse: anInteger2 [
	^ Array with:
		(self verses at: anInteger)
]

{ #category : #reciting }
TwelveDays >> verse: anInteger [
	^ 'On the {1} day of Christmas my true love gave to me: {2}.'
		format: { self ordinal: anInteger. self giftsOnDay: anInteger }
]

{ #category : #reciting }
TwelveDays >> verses [
	^ #(
	'On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.'
	'On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.'
	'On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
	'On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
	'On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
	'On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 
	'On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 
	'On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 
	'On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'
	'On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 
	'On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 
	'On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.'  )
]
