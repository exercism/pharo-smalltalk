"
# Resistor Color

Resistors have color coded bands, where each color maps to a number. The first 2 bands of a resistor have a simple encoding scheme: each color maps to a single number.

These colors are encoded as follows:

- Black: 0
- Brown: 1
- Red: 2
- Orange: 3
- Yellow: 4
- Green: 5
- Blue: 6
- Violet: 7
- Grey: 8
- White: 9

Mnemonics map the colors to the numbers, that, when stored as an array, happen to map to their index in the array: Better Be Right Or Your Great Big Values Go Wrong.

More information on the color encoding of resistors can be found in the [Electronic color code Wikipedia article](https://en.wikipedia.org/wiki/Electronic_color_code)

## Hint

TBD

"
Class {
	#name : #ResistorColorTest,
	#superclass : #ExercismTest,
	#instVars : [
		'resistorColorCalculator'
	],
	#category : #'ExercismWIP-ResistorColor'
}

{ #category : #config }
ResistorColorTest class >> uuid [
	"Answer a unique id for this exercise"
	^'398a01da-2b3f-0d00-a2dc-a43009f0590c'
]

{ #category : #config }
ResistorColorTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
ResistorColorTest >> setUp [
	resistorColorCalculator := ResistorColor new
]

{ #category : #test }
ResistorColorTest >> testColorCodesBlack [
	| result |

	result := resistorColorCalculator colorCodeColor: 'black' .
	self assert: result equals: 0
]

{ #category : #test }
ResistorColorTest >> testColorCodesOrange [
	| result |

	result := resistorColorCalculator colorCodeColor: 'orange' .
	self assert: result equals: 3
]

{ #category : #test }
ResistorColorTest >> testColorCodesWhite [
	| result |

	result := resistorColorCalculator colorCodeColor: 'white' .
	self assert: result equals: 9
]

{ #category : #test }
ResistorColorTest >> testColors [
	| result |

	result := resistorColorCalculator colors.
	self assert: result equals: #('black' 'brown' 'red' 'orange' 'yellow' 'green' 'blue' 'violet' 'grey' 'white' )
]
