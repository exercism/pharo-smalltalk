"
# OcrNumbers

# Description

Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or whether it is garbled.

## Step One

To begin with, convert a simple binary font to a string containing 0 or 1.

The binary font uses pipes and underscores, four rows high and three columns wide.

```text
     _   #
    | |  # zero.
    |_|  #
         # the fourth row is always blank
```

Is converted to ""0""

```text
         #
      |  # one.
      |  #
         # (blank fourth row)
```

Is converted to ""1""

If the input is the correct size, but not recognizable, your program should return '?'

If the input is the incorrect size, your program should return an error.

## Step Two

Update your program to recognize multi-character binary strings, replacing garbled numbers with ?

## Step Three

Update your program to recognize all numbers 0 through 9, both individually and as part of a larger string.

```text
 _
 _|
|_

```

Is converted to ""2""

```text
      _  _     _  _  _  _  _  _  #
    | _| _||_||_ |_   ||_||_|| | # decimal numbers.
    ||_  _|  | _||_|  ||_| _||_| #
                                 # fourth line is always blank
```

Is converted to ""1234567890""

## Step Four

Update your program to handle multiple numbers, one per line.
When converting several lines, join the lines with commas.

```text
    _  _
  | _| _|
  ||_  _|

    _  _
|_||_ |_
  | _||_|

 _  _  _
  ||_||_|
  ||_| _|

```

Is converted to ""123,456,789"".

## Instructions append


The following text could be parsed from this comment and used to recognize characters:
'    _  _     _  _  _  _  _  _ '
'  | _| _||_||_ |_   ||_||_|| |'
'  ||_  _|  | _||_|  ||_| _||_|'
'                              '

"
Class {
	#name : 'OcrNumbersTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'ocrNumbers'
	],
	#category : 'Exercise@OcrNumbers',
	#package : 'Exercise@OcrNumbers'
}

{ #category : 'config' }
OcrNumbersTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(ExercismExercise for: self)
		difficulty: 6;
		topics: #('matrices' 'parsing' 'pattern_recognition');
		yourself
]

{ #category : 'config' }
OcrNumbersTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d586e915-466a-4806-8a00-7f325aabd493'
]

{ #category : 'config' }
OcrNumbersTest class >> version [
	"Generated from specification: 6 April 2025"
	^'Not specified'
]

{ #category : 'running' }
OcrNumbersTest >> setUp [
	super setUp.
	ocrNumbers := OcrNumbers from: self class comment
]

{ #category : 'tests' }
OcrNumbersTest >> test01_Recognizes0 [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'Recognizes 0'>
	<exeTestUUID: '5ee54e1a-b554-4bf3-a056-9a7976c3f7e8'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' '| |' '|_|' '   ') .
	self assert: result equals: '0'
]

{ #category : 'tests' }
OcrNumbersTest >> test02_Recognizes1 [
	<exeTestName: 'Recognizes 1'>
	<exeTestUUID: '027ada25-17fd-4d78-aee6-35a19623639d'>

	| result |

	result := ocrNumbers convertRows: #('   ' '  |' '  |' '   ') .
	self assert: result equals: '1'
]

{ #category : 'tests' }
OcrNumbersTest >> test03_UnreadableButCorrectlySizedInputsReturn [
	<exeTestName: 'Unreadable but correctly sized inputs return ?'>
	<exeTestUUID: '3cce2dbd-01d9-4f94-8fae-419a822e89bb'>

	| result |

	result := ocrNumbers convertRows: #('   ' '  _' '  |' '   ') .
	self assert: result equals: '?'
]

{ #category : 'tests' }
OcrNumbersTest >> test04_InputWithANumberOfLinesThatIsNotAMultipleOfFourRaisesAnError [
	<exeTestName: 'Input with a number of lines that is not a multiple of four raises an error'>
	<exeTestUUID: 'cb19b733-4e36-4cf9-a4a1-6e6aac808b9a'>

	| result |

	self
		should: [ result := ocrNumbers convertRows: #(' _ ' '| |' '   ') ]
		raise: Error
		whoseDescriptionIncludes: 'Number of input lines is not a multiple of four'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
OcrNumbersTest >> test05_InputWithANumberOfColumnsThatIsNotAMultipleOfThreeRaisesAnError [
	<exeTestName: 'Input with a number of columns that is not a multiple of three raises an error'>
	<exeTestUUID: '235f7bd1-991b-4587-98d4-84206eec4cc6'>

	| result |

	self
		should: [ result := ocrNumbers convertRows: #('    ' '   |' '   |' '    ') ]
		raise: Error
		whoseDescriptionIncludes: 'Number of input columns is not a multiple of three'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
OcrNumbersTest >> test06_Recognizes110101100 [
	<exeTestName: 'Recognizes 110101100'>
	<exeTestUUID: '4a841794-73c9-4da9-a779-1f9837faff66'>

	| result |

	result := ocrNumbers convertRows: #('       _     _        _  _ ' '  |  || |  || |  |  || || |' '  |  ||_|  ||_|  |  ||_||_|' '                           ') .
	self assert: result equals: '110101100'
]

{ #category : 'tests' }
OcrNumbersTest >> test07_GarbledNumbersInAStringAreReplacedWith [
	<exeTestName: 'Garbled numbers in a string are replaced with ?'>
	<exeTestUUID: '70c338f9-85b1-4296-a3a8-122901cdfde8'>

	| result |

	result := ocrNumbers convertRows: #('       _     _           _ ' '  |  || |  || |     || || |' '  |  | _|  ||_|  |  ||_||_|' '                           ') .
	self assert: result equals: '11?10?1?0'
]

{ #category : 'tests' }
OcrNumbersTest >> test08_Recognizes2 [
	<exeTestName: 'Recognizes 2'>
	<exeTestUUID: 'ea494ff4-3610-44d7-ab7e-72fdef0e0802'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' ' _|' '|_ ' '   ') .
	self assert: result equals: '2'
]

{ #category : 'tests' }
OcrNumbersTest >> test09_Recognizes3 [
	<exeTestName: 'Recognizes 3'>
	<exeTestUUID: '1acd2c00-412b-4268-93c2-bd7ff8e05a2c'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' ' _|' ' _|' '   ') .
	self assert: result equals: '3'
]

{ #category : 'tests' }
OcrNumbersTest >> test10_Recognizes4 [
	<exeTestName: 'Recognizes 4'>
	<exeTestUUID: 'eaec6a15-be17-4b6d-b895-596fae5d1329'>

	| result |

	result := ocrNumbers convertRows: #('   ' '|_|' '  |' '   ') .
	self assert: result equals: '4'
]

{ #category : 'tests' }
OcrNumbersTest >> test11_Recognizes5 [
	<exeTestName: 'Recognizes 5'>
	<exeTestUUID: '440f397a-f046-4243-a6ca-81ab5406c56e'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' '|_ ' ' _|' '   ') .
	self assert: result equals: '5'
]

{ #category : 'tests' }
OcrNumbersTest >> test12_Recognizes6 [
	<exeTestName: 'Recognizes 6'>
	<exeTestUUID: 'f4c9cf6a-f1e2-4878-bfc3-9b85b657caa0'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' '|_ ' '|_|' '   ') .
	self assert: result equals: '6'
]

{ #category : 'tests' }
OcrNumbersTest >> test13_Recognizes7 [
	<exeTestName: 'Recognizes 7'>
	<exeTestUUID: 'e24ebf80-c611-41bb-a25a-ac2c0f232df5'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' '  |' '  |' '   ') .
	self assert: result equals: '7'
]

{ #category : 'tests' }
OcrNumbersTest >> test14_Recognizes8 [
	<exeTestName: 'Recognizes 8'>
	<exeTestUUID: 'b79cad4f-e264-4818-9d9e-77766792e233'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' '|_|' '|_|' '   ') .
	self assert: result equals: '8'
]

{ #category : 'tests' }
OcrNumbersTest >> test15_Recognizes9 [
	<exeTestName: 'Recognizes 9'>
	<exeTestUUID: '5efc9cfc-9227-4688-b77d-845049299e66'>

	| result |

	result := ocrNumbers convertRows: #(' _ ' '|_|' ' _|' '   ') .
	self assert: result equals: '9'
]

{ #category : 'tests' }
OcrNumbersTest >> test16_RecognizesStringOfDecimalNumbers [
	<exeTestName: 'Recognizes string of decimal numbers'>
	<exeTestUUID: 'f60cb04a-42be-494e-a535-3451c8e097a4'>

	| result |

	result := ocrNumbers convertRows: #('    _  _     _  _  _  _  _  _ ' '  | _| _||_||_ |_   ||_||_|| |' '  ||_  _|  | _||_|  ||_| _||_|' '                              ') .
	self assert: result equals: '1234567890'
]

{ #category : 'tests' }
OcrNumbersTest >> test17_NumbersSeparatedByEmptyLinesAreRecognizedLinesAreJoinedByCommas [
	<exeTestName: 'Numbers separated by empty lines are recognized. Lines are joined by commas.'>
	<exeTestUUID: 'b73ecf8b-4423-4b36-860d-3710bdb8a491'>

	| result |

	result := ocrNumbers convertRows: #('    _  _ ' '  | _| _|' '  ||_  _|' '         ' '    _  _ ' '|_||_ |_ ' '  | _||_|' '         ' ' _  _  _ ' '  ||_||_|' '  ||_| _|' '         ') .
	self assert: result equals: '123,456,789'
]
