"
# Resistor Color Duo

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

You will need some form of lookup table of colours to calculate the value. You don't necessarily have to use a Dictionary to do this.


"
Class {
	#name : #ResistorColorDuoTest,
	#superclass : #ExercismTest,
	#instVars : [
		'resistorColorDuoCalculator'
	],
	#category : #'Exercise@ResistorColorDuo'
}

{ #category : #config }
ResistorColorDuoTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	
	^(self createExerciseAfter: TwoFerTest)
		difficulty: 1;
		topics: #('arrays' 'strings' 'math');
		yourself
]

{ #category : #generator }
ResistorColorDuoTest class >> generator [
	"Potential generator hints"
	
	^ {'valueColours:' -> 'valueWithColours:' }
]

{ #category : #config }
ResistorColorDuoTest class >> uuid [
	"Answer a unique id for this exercise"
	^'4c6e4b89-cea1-45ee-aa7e-c67c30cd1ec6'
]

{ #category : #config }
ResistorColorDuoTest class >> version [
	"Generated from specification: 10 April 2019"
	^'2.0.0'
]

{ #category : #running }
ResistorColorDuoTest >> setUp [
	super setUp.
	resistorColorDuoCalculator := ResistorColorDuo new
]

{ #category : #tests }
ResistorColorDuoTest >> test01_BrownAndBlack [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'Brown and black'>
	<exeTestUUID: 'ce11995a-5b93-4950-a5e9-93423693b2fc'>

	| result |

	result := resistorColorDuoCalculator valueWithColors: #('brown' 'black') .
	self assert: result equals: 10
]

{ #category : #tests }
ResistorColorDuoTest >> test02_BlueAndGrey [
	<exeTestName: 'Blue and grey'>
	<exeTestUUID: '7bf82f7a-af23-48ba-a97d-38d59406a920'>

	| result |

	result := resistorColorDuoCalculator valueWithColors: #('blue' 'grey') .
	self assert: result equals: 68
]

{ #category : #tests }
ResistorColorDuoTest >> test03_YellowAndViolet [
	<exeTestName: 'Yellow and violet'>
	<exeTestUUID: 'f1886361-fdfd-4693-acf8-46726fe24e0c'>

	| result |

	result := resistorColorDuoCalculator valueWithColors: #('yellow' 'violet') .
	self assert: result equals: 47
]

{ #category : #tests }
ResistorColorDuoTest >> test04_WhiteAndRed [
	<exeTestName: 'White and red'>
	<exeTestUUID: 'b7a6cbd2-ae3c-470a-93eb-56670b305640'>

	| result |

	result := resistorColorDuoCalculator valueWithColors: #('white' 'red') .
	self assert: result equals: 92
]

{ #category : #tests }
ResistorColorDuoTest >> test05_OrangeAndOrange [
	<exeTestName: 'Orange and orange'>
	<exeTestUUID: '77a8293d-2a83-4016-b1af-991acc12b9fe'>

	| result |

	result := resistorColorDuoCalculator valueWithColors: #('orange' 'orange') .
	self assert: result equals: 33
]

{ #category : #tests }
ResistorColorDuoTest >> test06_IgnoreAdditionalColors [
	<exeTestName: 'Ignore additional colors'>
	<exeTestUUID: '0c4fb44f-db7c-4d03-afa8-054350f156a8'>

	| result |

	result := resistorColorDuoCalculator valueWithColors: #('green' 'brown' 'orange') .
	self assert: result equals: 51
]

{ #category : #tests }
ResistorColorDuoTest >> test07_BlackAndBrownOnedigit [
	<exeTestName: 'Black and brown, one-digit'>
	<exeTestUUID: '4a8ceec5-0ab4-4904-88a4-daf953a5e818'>

	| result |

	result := resistorColorDuoCalculator valueWithColors: #('black' 'brown') .
	self assert: result equals: 1
]

{ #category : #extra }
ResistorColorDuoTest >> testDetectInvalidColors [
	"first color"
	self
		should: [resistorColorDuoCalculator valueWithColors: #('unknown' 'black' )]
		raise: Error
		whoseDescriptionIncludes: 'Invalid color'
		description: 'Should get an error with an unknown color'.
		
	"second color"
	self
		should: [resistorColorDuoCalculator valueWithColors: #('black' 'unknown' )]
		raise: Error
		whoseDescriptionIncludes: 'Invalid color'
		description: 'Should get an error with an unknown color'
]
