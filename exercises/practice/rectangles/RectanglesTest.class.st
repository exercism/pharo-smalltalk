"
# Rectangles

# Description

Count the rectangles in an ASCII diagram like the one below.

```text
   +--+
  ++  |
+-++--+
|  |  |
+--+--+
```

The above diagram contains these 6 rectangles:

```text


+-----+
|     |
+-----+
```

```text
   +--+
   |  |
   |  |
   |  |
   +--+
```

```text
   +--+
   |  |
   +--+


```

```text


   +--+
   |  |
   +--+
```

```text


+--+
|  |
+--+
```

```text

  ++
  ++


```

You may assume that the input is always a proper rectangle (i.e. the length of every line equals the length of the first line).

## Instructions append

You may be able to use a brute force strategy to solve this one.

"
Class {
	#name : 'RectanglesTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'rectangles'
	],
	#category : 'Exercise@Rectangles',
	#package : 'Exercise@Rectangles'
}

{ #category : 'config' }
RectanglesTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(ExercismExercise for: self)
		difficulty: 7;
		topics: #('transforming' 'parsing' 'pattern_recognition');
		yourself
	
				
]

{ #category : 'config' }
RectanglesTest class >> exerciseTitle [

	"Answer the exercise title string, obtained from metadata.toml"
	
	^ 'Rectangles'
]

{ #category : 'config' }
RectanglesTest class >> uuid [
	"Answer a unique id for this exercise"
	^'9d24e116-9d41-0d00-8ff7-3ca508866539'
]

{ #category : 'config' }
RectanglesTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.1.0'
]

{ #category : 'running' }
RectanglesTest >> setUp [
	super setUp.
	rectangles := Rectangles new
]

{ #category : 'tests' }
RectanglesTest >> test01_NoRows [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'no rows'>
	<exeTestUUID: '485b7bab-4150-40aa-a8db-73013427d08c'>

	| result |

	result := rectangles rectanglesFromStrings: #() .
	self assert: result equals: 0
]

{ #category : 'tests' }
RectanglesTest >> test02_NoColumns [
	<exeTestName: 'no columns'>
	<exeTestUUID: '076929ed-27e8-45dc-b14b-08279944dc49'>

	| result |

	result := rectangles rectanglesFromStrings: #('') .
	self assert: result equals: 0
]

{ #category : 'tests' }
RectanglesTest >> test03_NoRectangles [
	<exeTestName: 'no rectangles'>
	<exeTestUUID: '0a8abbd1-a0a4-4180-aa4e-65c1b1a073fa'>

	| result |

	result := rectangles rectanglesFromStrings: #(' ') .
	self assert: result equals: 0
]

{ #category : 'tests' }
RectanglesTest >> test04_OneRectangle [
	<exeTestName: 'one rectangle'>
	<exeTestUUID: 'a4ba42e9-4e7f-4973-b7c7-4ce0760ac6cd'>

	| result |

	result := rectangles rectanglesFromStrings: #('+-+' '| |' '+-+') .
	self assert: result equals: 1
]

{ #category : 'tests' }
RectanglesTest >> test05_TwoRectanglesWithoutSharedParts [
	<exeTestName: 'two rectangles without shared parts'>
	<exeTestUUID: 'ced06550-83da-4d23-98b7-d24152e0db93'>

	| result |

	result := rectangles rectanglesFromStrings: #('  +-+' '  | |' '+-+-+' '| |  ' '+-+  ') .
	self assert: result equals: 2
]

{ #category : 'tests' }
RectanglesTest >> test06_FiveRectanglesWithSharedParts [
	<exeTestName: 'five rectangles with shared parts'>
	<exeTestUUID: '5942d69a-a07c-41c8-8b93-2d13877c706a'>

	| result |

	result := rectangles rectanglesFromStrings: #('  +-+' '  | |' '+-+-+' '| | |' '+-+-+') .
	self assert: result equals: 5
]

{ #category : 'tests' }
RectanglesTest >> test07_RectangleOfHeight1IsCounted [
	<exeTestName: 'rectangle of height 1 is counted'>
	<exeTestUUID: '82d70be4-ab37-4bf2-a433-e33778d3bbf1'>

	| result |

	result := rectangles rectanglesFromStrings: #('+--+' '+--+') .
	self assert: result equals: 1
]

{ #category : 'tests' }
RectanglesTest >> test08_RectangleOfWidth1IsCounted [
	<exeTestName: 'rectangle of width 1 is counted'>
	<exeTestUUID: '57f1bc0e-2782-401e-ab12-7c01d8bfc2e0'>

	| result |

	result := rectangles rectanglesFromStrings: #('++' '||' '++') .
	self assert: result equals: 1
]

{ #category : 'tests' }
RectanglesTest >> test09_1x1SquareIsCounted [
	<exeTestName: '1x1 square is counted'>
	<exeTestUUID: 'ef0bb65c-bd80-4561-9535-efc4067054f9'>

	| result |

	result := rectangles rectanglesFromStrings: #('++' '++') .
	self assert: result equals: 1
]

{ #category : 'tests' }
RectanglesTest >> test10_OnlyCompleteRectanglesAreCounted [
	<exeTestName: 'only complete rectangles are counted'>
	<exeTestUUID: 'e1e1d444-e926-4d30-9bf3-7d8ec9a9e330'>

	| result |

	result := rectangles rectanglesFromStrings: #('  +-+' '    |' '+-+-+' '| | -' '+-+-+') .
	self assert: result equals: 1
]

{ #category : 'tests' }
RectanglesTest >> test11_RectanglesCanBeOfDifferentSizes [
	<exeTestName: 'rectangles can be of different sizes'>
	<exeTestUUID: 'ca021a84-1281-4a56-9b9b-af14113933a4'>

	| result |

	result := rectangles rectanglesFromStrings: #('+------+----+' '|      |    |' '+---+--+    |' '|   |       |' '+---+-------+') .
	self assert: result equals: 3
]

{ #category : 'tests' }
RectanglesTest >> test12_CornerIsRequiredForARectangleToBeComplete [
	<exeTestName: 'corner is required for a rectangle to be complete'>
	<exeTestUUID: '51f689a7-ef3f-41ae-aa2f-5ea09ad897ff'>

	| result |

	result := rectangles rectanglesFromStrings: #('+------+----+' '|      |    |' '+------+    |' '|   |       |' '+---+-------+') .
	self assert: result equals: 2
]

{ #category : 'tests' }
RectanglesTest >> test13_LargeInputWithManyRectangles [
	<exeTestName: 'large input with many rectangles'>
	<exeTestUUID: 'd78fe379-8c1b-4d3c-bdf7-29bfb6f6dc66'>

	| result |

	result := rectangles rectanglesFromStrings: #('+---+--+----+' '|   +--+----+' '+---+--+    |' '|   +--+----+' '+---+--+--+-+' '+---+--+--+-+' '+------+  | |' '          +-+') .
	self assert: result equals: 60
]

{ #category : 'tests' }
RectanglesTest >> test14_RectanglesMustHaveFourSides [
	<exeTestName: 'rectangles must have four sides'>
	<exeTestUUID: '6ef24e0f-d191-46da-b929-4faca24b4cd2'>

	| result |

	result := rectangles rectanglesFromStrings: #('+-+ +-+' '| | | |' '+-+-+-+' '  | |  ' '+-+-+-+' '| | | |' '+-+ +-+') .
	self assert: result equals: 5
]
