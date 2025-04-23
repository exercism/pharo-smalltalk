"
# AllYourBase

# Introduction

You've just been hired as professor of mathematics.
Your first week went well, but something is off in your second week.
The problem is that every answer given by your students is wrong!
Luckily, your math skills have allowed you to identify the problem: the student answers _are_ correct, but they're all in base 2 (binary)!
Amazingly, it turns out that each week, the students use a different base.
To help you quickly verify the student answers, you'll be building a tool to translate between bases.

# Instructions

Convert a sequence of digits in one base, representing a number, into a sequence of digits in another base, representing the same number.

~~~~exercism/note
Try to implement the conversion yourself.
Do not use something else to perform the conversion for you.
~~~~

## About [Positional Notation][positional-notation]

In positional notation, a number in base **b** can be understood as a linear combination of powers of **b**.

The number 42, _in base 10_, means:

`(4 × 10¹) + (2 × 10⁰)`

The number 101010, _in base 2_, means:

`(1 × 2⁵) + (0 × 2⁴) + (1 × 2³) + (0 × 2²) + (1 × 2¹) + (0 × 2⁰)`

The number 1120, _in base 3_, means:

`(1 × 3³) + (1 × 3²) + (2 × 3¹) + (0 × 3⁰)`

_Yes. Those three numbers above are exactly the same. Congratulations!_

[positional-notation]: https://en.wikipedia.org/wiki/Positional_notation

## Instructions append

You may want to explore Number class and its methods in Pharo, and how to add to OrderedCollection in different order.

"
Class {
	#name : 'AllYourBaseTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'allYourBase'
	],
	#category : 'Exercise@AllYourBase',
	#package : 'Exercise@AllYourBase'
}

{ #category : 'config' }
AllYourBaseTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise
	e.g."
	
	^(ExercismExercise for: self)
		difficulty: 4;
		topics: #('numbers' 'while-loops' 'lists' 'math-operators' 'exceptions');
		yourself
]

{ #category : 'config' }
AllYourBaseTest class >> exerciseTitle [

	"Answer the exercise title string, obtained from metadata.toml"
	
	^ 'All Your Base'
]

{ #category : 'config' }
AllYourBaseTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d7c5ed6b-d42c-406a-9912-9ee952a955ba'
]

{ #category : 'config' }
AllYourBaseTest class >> version [
	"Generated from specification: 23 April 2025"
	^'Not specified'
]

{ #category : 'running' }
AllYourBaseTest >> setUp [
	super setUp.
	allYourBase := AllYourBase new
]

{ #category : 'tests' }
AllYourBaseTest >> test01_SingleBitOneToDecimal [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'single bit one to decimal'>
	<exeTestUUID: '5ce422f9-7a4b-4f44-ad29-49c67cb32d2c'>

	| result |

	result := allYourBase rebaseInputBase: 2 digits: #(1) outputBase: 10 .
	self assert: result equals: #(1)
]

{ #category : 'tests' }
AllYourBaseTest >> test02_BinaryToSingleDecimal [
	<exeTestName: 'binary to single decimal'>
	<exeTestUUID: '0cc3fea8-bb79-46ac-a2ab-5a2c93051033'>

	| result |

	result := allYourBase rebaseInputBase: 2 digits: #(1 0 1) outputBase: 10 .
	self assert: result equals: #(5)
]

{ #category : 'tests' }
AllYourBaseTest >> test03_SingleDecimalToBinary [
	<exeTestName: 'single decimal to binary'>
	<exeTestUUID: 'f12db0f9-0d3d-42c2-b3ba-e38cb375a2b8'>

	| result |

	result := allYourBase rebaseInputBase: 10 digits: #(5) outputBase: 2 .
	self assert: result equals: #(1 0 1)
]

{ #category : 'tests' }
AllYourBaseTest >> test04_BinaryToMultipleDecimal [
	<exeTestName: 'binary to multiple decimal'>
	<exeTestUUID: '2c45cf54-6da3-4748-9733-5a3c765d925b'>

	| result |

	result := allYourBase rebaseInputBase: 2 digits: #(1 0 1 0 1 0) outputBase: 10 .
	self assert: result equals: #(4 2)
]

{ #category : 'tests' }
AllYourBaseTest >> test05_DecimalToBinary [
	<exeTestName: 'decimal to binary'>
	<exeTestUUID: '65ddb8b4-8899-4fcc-8618-181b2cf0002d'>

	| result |

	result := allYourBase rebaseInputBase: 10 digits: #(4 2) outputBase: 2 .
	self assert: result equals: #(1 0 1 0 1 0)
]

{ #category : 'tests' }
AllYourBaseTest >> test06_TrinaryToHexadecimal [
	<exeTestName: 'trinary to hexadecimal'>
	<exeTestUUID: '8d418419-02a7-4824-8b7a-352d33c6987e'>

	| result |

	result := allYourBase rebaseInputBase: 3 digits: #(1 1 2 0) outputBase: 16 .
	self assert: result equals: #(2 10)
]

{ #category : 'tests' }
AllYourBaseTest >> test07_HexadecimalToTrinary [
	<exeTestName: 'hexadecimal to trinary'>
	<exeTestUUID: 'd3901c80-8190-41b9-bd86-38d988efa956'>

	| result |

	result := allYourBase rebaseInputBase: 16 digits: #(2 10) outputBase: 3 .
	self assert: result equals: #(1 1 2 0)
]

{ #category : 'tests' }
AllYourBaseTest >> test08_15bitInteger [
	<exeTestName: '15-bit integer'>
	<exeTestUUID: '5d42f85e-21ad-41bd-b9be-a3e8e4258bbf'>

	| result |

	result := allYourBase rebaseInputBase: 97 digits: #(3 46 60) outputBase: 73 .
	self assert: result equals: #(6 10 45)
]

{ #category : 'tests' }
AllYourBaseTest >> test09_EmptyList [
	<exeTestName: 'empty list'>
	<exeTestUUID: 'd68788f7-66dd-43f8-a543-f15b6d233f83'>

	| result |

	result := allYourBase rebaseInputBase: 2 digits: #() outputBase: 10 .
	self assert: result equals: #(0)
]

{ #category : 'tests' }
AllYourBaseTest >> test10_SingleZero [
	<exeTestName: 'single zero'>
	<exeTestUUID: '5e27e8da-5862-4c5f-b2a9-26c0382b6be7'>

	| result |

	result := allYourBase rebaseInputBase: 10 digits: #(0) outputBase: 2 .
	self assert: result equals: #(0)
]

{ #category : 'tests' }
AllYourBaseTest >> test11_MultipleZeros [
	<exeTestName: 'multiple zeros'>
	<exeTestUUID: '2e1c2573-77e4-4b9c-8517-6c56c5bcfdf2'>

	| result |

	result := allYourBase rebaseInputBase: 10 digits: #(0 0 0) outputBase: 2 .
	self assert: result equals: #(0)
]

{ #category : 'tests' }
AllYourBaseTest >> test12_LeadingZeros [
	<exeTestName: 'leading zeros'>
	<exeTestUUID: '3530cd9f-8d6d-43f5-bc6e-b30b1db9629b'>

	| result |

	result := allYourBase rebaseInputBase: 7 digits: #(0 6 0) outputBase: 10 .
	self assert: result equals: #(4 2)
]

{ #category : 'tests' }
AllYourBaseTest >> test13_InputBaseIsOne [
	<exeTestName: 'input base is one'>
	<exeTestUUID: 'a6b476a1-1901-4f2a-92c4-4d91917ae023'>

	| result |

	self
		should: [ result := allYourBase rebaseInputBase: 1 digits: #(0) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test14_InputBaseIsZero [
	<exeTestName: 'input base is zero'>
	<exeTestUUID: 'e21a693a-7a69-450b-b393-27415c26a016'>

	| result |

	self
		should: [ result := allYourBase rebaseInputBase: 0 digits: #() outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test15_InputBaseIsNegative [
	<exeTestName: 'input base is negative'>
	<exeTestUUID: '54a23be5-d99e-41cc-88e0-a650ffe5fcc2'>

	| result |

	self
		should: [ result := allYourBase rebaseInputBase:  -2 digits: #(1) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test16_NegativeDigit [
	<exeTestName: 'negative digit'>
	<exeTestUUID: '9eccf60c-dcc9-407b-95d8-c37b8be56bb6'>
	
	| result |
		
	self 
	should: [ result := allYourBase rebaseInputBase: 2 digits: #(1  -1 1 0 1 0) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'all digits must satisfy 0 <= d < input base'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test17_InvalidPositiveDigit [
	<exeTestName: 'invalid positive digit'>
	<exeTestUUID: '232fa4a5-e761-4939-ba0c-ed046cd0676a'>

	| result |
	self	
		should: [result := allYourBase rebaseInputBase: 2 digits: #( 1 2 1 0 1 0 ) outputBase: 10 ]
		raise: Error
		whoseDescriptionIncludes: 'all digits must satisfy 0 <= d < input base'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test18_OutputBaseIsOne [
	<exeTestName: 'output base is one'>
	<exeTestUUID: '14238f95-45da-41dc-95ce-18f860b30ad3'>

	| result |

	self
	should: [ result := allYourBase rebaseInputBase: 2 digits: #(1 0 1 0 1 0) outputBase: 1 ]
		raise: Error
		whoseDescriptionIncludes: 'output base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test19_OutputBaseIsZero [
	<exeTestName: 'output base is zero'>
	<exeTestUUID: '73dac367-da5c-4a37-95fe-c87fad0a4047'>

	| result |

	self
		should: [ result := allYourBase rebaseInputBase: 10 digits: #(7) outputBase: 0 ]
		raise: Error
		whoseDescriptionIncludes: 'output base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test20_OutputBaseIsNegative [
	<exeTestName: 'output base is negative'>
	<exeTestUUID: '13f81f42-ff53-4e24-89d9-37603a48ebd9'>

	| result |

	self
		should: [ result := allYourBase rebaseInputBase: 2 digits: #(1) outputBase:  -7 ]
		raise: Error
		whoseDescriptionIncludes: 'output base must be >= 2'
		description: 'Should get an error with the correct description'
]

{ #category : 'tests' }
AllYourBaseTest >> test21_BothBasesAreNegative [
	<exeTestName: 'both bases are negative'>
	<exeTestUUID: '0e6c895d-8a5d-4868-a345-309d094cfe8d'>

	| result |

	self
		should: [ result := allYourBase rebaseInputBase:  -2 digits: #(1) outputBase:  -7 ]
		raise: Error
		whoseDescriptionIncludes: 'input base must be >= 2'
		description: 'Should get an error with the correct description'
]
