Class {
	#name : #TwelveDays,
	#superclass : #Object,
	#category : #'ExercismWIP-TwelveDays'
}

{ #category : #reciting }
TwelveDays >> reciteStartVerse: anInteger endVerse: anInteger2 [ 
	^ Array with: (#(
		'On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.'
		'On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.'
		'On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' ) at: anInteger )
]
