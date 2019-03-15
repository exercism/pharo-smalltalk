"
# Ocr Numbers

Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is
represented, or whether it is garbled.

# Step One

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

# Step Two

Update your program to recognize multi-character binary strings, replacing garbled numbers with ?

# Step Three

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

# Step Four

Update your program to handle multiple numbers, one per line. When converting several lines, join the lines with commas.

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

Is converted to ""123,456,789""

## Hint

TBD

"
Class {
	#name : #OcrNumbersTest,
	#superclass : #ExercismTest,
	#instVars : [
		'ocrNumbersCalculator'
	],
	#category : #'ExercismWIP-OcrNumbers'
}

{ #category : #config }
OcrNumbersTest class >> uuid [
	"Answer a unique id for this exercise"
	^'b018f6bb-8040-0d00-8140-5e7301deb008'
]

{ #category : #config }
OcrNumbersTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.2.0'
]

{ #category : #setup }
OcrNumbersTest >> setUp [
	ocrNumbersCalculator := OcrNumbers new
]

{ #category : #tests }
OcrNumbersTest >> test01_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes0 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' '| |' '|_|' '   ' ) .
	self assert: result equals: '0'
]

{ #category : #tests }
OcrNumbersTest >> test02_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes1 [
	| result |

	result := ocrNumbersCalculator convertRows: #('   ' '  |' '  |' '   ' ) .
	self assert: result equals: '1'
]

{ #category : #tests }
OcrNumbersTest >> test03_ConvertsLinesOfOCRNumbersToAStringOfIntegersUnreadableButCorrectlySizedInputsReturn [
	| result |

	result := ocrNumbersCalculator convertRows: #('   ' '  _' '  |' '   ' ) .
	self assert: result equals: '?'
]

{ #category : #tests }
OcrNumbersTest >> test04_ConvertsLinesOfOCRNumbersToAStringOfIntegersInputWithANumberOfLinesThatIsNotAMultipleOfFourRaisesAnError [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' '| |' '   ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Number of input lines is not a multiple of four'); yourself)
]

{ #category : #tests }
OcrNumbersTest >> test05_ConvertsLinesOfOCRNumbersToAStringOfIntegersInputWithANumberOfColumnsThatIsNotAMultipleOfThreeRaisesAnError [
	| result |

	result := ocrNumbersCalculator convertRows: #('    ' '   |' '   |' '    ' ) .
	self assert: result equals: ((Dictionary new) add: ('error'->'Number of input columns is not a multiple of three'); yourself)
]

{ #category : #tests }
OcrNumbersTest >> test06_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes110101100 [
	| result |

	result := ocrNumbersCalculator convertRows: #('       _     _        _  _ ' '  |  || |  || |  |  || || |' '  |  ||_|  ||_|  |  ||_||_|' '                           ' ) .
	self assert: result equals: '110101100'
]

{ #category : #tests }
OcrNumbersTest >> test07_ConvertsLinesOfOCRNumbersToAStringOfIntegersGarbledNumbersInAStringAreReplacedWith [
	| result |

	result := ocrNumbersCalculator convertRows: #('       _     _           _ ' '  |  || |  || |     || || |' '  |  | _|  ||_|  |  ||_||_|' '                           ' ) .
	self assert: result equals: '11?10?1?0'
]

{ #category : #tests }
OcrNumbersTest >> test08_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes2 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' ' _|' '|_ ' '   ' ) .
	self assert: result equals: '2'
]

{ #category : #tests }
OcrNumbersTest >> test09_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes3 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' ' _|' ' _|' '   ' ) .
	self assert: result equals: '3'
]

{ #category : #tests }
OcrNumbersTest >> test10_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes4 [
	| result |

	result := ocrNumbersCalculator convertRows: #('   ' '|_|' '  |' '   ' ) .
	self assert: result equals: '4'
]

{ #category : #tests }
OcrNumbersTest >> test11_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes5 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' '|_ ' ' _|' '   ' ) .
	self assert: result equals: '5'
]

{ #category : #tests }
OcrNumbersTest >> test12_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes6 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' '|_ ' '|_|' '   ' ) .
	self assert: result equals: '6'
]

{ #category : #tests }
OcrNumbersTest >> test13_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes7 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' '  |' '  |' '   ' ) .
	self assert: result equals: '7'
]

{ #category : #tests }
OcrNumbersTest >> test14_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes8 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' '|_|' '|_|' '   ' ) .
	self assert: result equals: '8'
]

{ #category : #tests }
OcrNumbersTest >> test15_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizes9 [
	| result |

	result := ocrNumbersCalculator convertRows: #(' _ ' '|_|' ' _|' '   ' ) .
	self assert: result equals: '9'
]

{ #category : #tests }
OcrNumbersTest >> test16_ConvertsLinesOfOCRNumbersToAStringOfIntegersRecognizesStringOfDecimalNumbers [
	| result |

	result := ocrNumbersCalculator convertRows: #('    _  _     _  _  _  _  _  _ ' '  | _| _||_||_ |_   ||_||_|| |' '  ||_  _|  | _||_|  ||_| _||_|' '                              ' ) .
	self assert: result equals: '1234567890'
]

{ #category : #tests }
OcrNumbersTest >> test17_ConvertsLinesOfOCRNumbersToAStringOfIntegersNumbersSeparatedByEmptyLinesAreRecognizedLinesAreJoinedByCommas [
	| result |

	result := ocrNumbersCalculator convertRows: #('    _  _ ' '  | _| _|' '  ||_  _|' '         ' '    _  _ ' '|_||_ |_ ' '  | _||_|' '         ' ' _  _  _ ' '  ||_||_|' '  ||_| _|' '         ' ) .
	self assert: result equals: '123,456,789'
]
