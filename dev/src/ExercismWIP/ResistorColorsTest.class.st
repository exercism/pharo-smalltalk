"
# Resistor Colors

If you want to build something using a Raspberry Pi, you'll probably use _resistors_. For this exercise, you need to know two things about them:

* Each resistor has a resistance value.
* Resistors are small - so small in fact that if you printed the resistance value on them, it would be hard to read.
To get around this problem, manufacturers print color-coded bands onto the resistors to denote their resistance values. Each band acts as a digit of a number. For example, if they printed a brown band (value 1) followed by a green band (value 5), it would translate to the number 15.

In this exercise, you are going to create a helpful program so that you don't have to remember the values of the bands. The program will take two colors as input, and output the correct number.

The band colors are encoded as follows:

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

## Hint

TBD

"
Class {
	#name : #ResistorColorsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'resistorColorsCalculator'
	],
	#category : #'ExercismWIP-ResistorColors'
}

{ #category : #config }
ResistorColorsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'c698dfbb-8040-0d00-8127-69c701deb008'
]

{ #category : #config }
ResistorColorsTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.0.0'
]

{ #category : #setup }
ResistorColorsTest >> setUp [
	resistorColorsCalculator := ResistorColors new
]

{ #category : #tests }
ResistorColorsTest >> test01_BrownAndBlack [
	| result |

	result := resistorColorsCalculator valueColors: #('brown' 'black' ) .
	self assert: result equals: 10
]

{ #category : #tests }
ResistorColorsTest >> test02_BlueAndGrey [
	| result |

	result := resistorColorsCalculator valueColors: #('blue' 'grey' ) .
	self assert: result equals: 68
]

{ #category : #tests }
ResistorColorsTest >> test03_YellowAndViolet [
	| result |

	result := resistorColorsCalculator valueColors: #('yellow' 'violet' ) .
	self assert: result equals: 47
]

{ #category : #tests }
ResistorColorsTest >> test04_OrangeAndOrange [
	| result |

	result := resistorColorsCalculator valueColors: #('orange' 'orange' ) .
	self assert: result equals: 33
]
