"
# Flatten Array

Take a nested list and return a single flattened list with all values except nil/null.

The challenge is to write a function that accepts an arbitrarily-deep nested list-like structure and returns a flattened structure without any nil/null values.

For Example

input: [1,[2,3,null,4],[null],5]

output: [1,2,3,4,5]

## Hint

TBD

"
Class {
	#name : #FlattenArrayTest,
	#superclass : #ExercismTest,
	#instVars : [
		'flattenArrayCalculator'
	],
	#category : #'ExercismWIP-FlattenArray'
}

{ #category : #config }
FlattenArrayTest class >> uuid [
	"Answer a unique id for this exercise"
	^'3b84ebbb-8040-0d00-8133-a14701deb008'
]

{ #category : #config }
FlattenArrayTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.2.0'
]

{ #category : #setup }
FlattenArrayTest >> setUp [
	flattenArrayCalculator := FlattenArray new
]

{ #category : #tests }
FlattenArrayTest >> test01_NoNesting [
	| result |

	result := flattenArrayCalculator flattenArray: #(0 1 2 ) .
	self assert: result equals: #(0 1 2 )
]

{ #category : #tests }
FlattenArrayTest >> test02_FlattensArrayWithJustIntegersPresent [
	| result |

	result := flattenArrayCalculator flattenArray: #(1 #(2 3 4 5 6 7 ) 8 ) .
	self assert: result equals: #(1 2 3 4 5 6 7 8 )
]

{ #category : #tests }
FlattenArrayTest >> test03_5LevelNesting [
	| result |

	result := flattenArrayCalculator flattenArray: #(0 2 #(#(2 3 ) 8 100 4 #(#(#(50 ) ) ) )  -2 ) .
	self assert: result equals: #(0 2 2 3 8 100 4 50  -2 )
]

{ #category : #tests }
FlattenArrayTest >> test04_6LevelNesting [
	| result |

	result := flattenArrayCalculator flattenArray: #(1 #(2 #(#(3 ) ) #(4 #(#(5 ) ) ) 6 7 ) 8 ) .
	self assert: result equals: #(1 2 3 4 5 6 7 8 )
]

{ #category : #tests }
FlattenArrayTest >> test05_6LevelNestListWithNullValues [
	| result |

	result := flattenArrayCalculator flattenArray: #(0 2 #(#(2 3 ) 8 #(#(100 ) ) nil #(#(nil ) ) )  -2 ) .
	self assert: result equals: #(0 2 2 3 8 100  -2 )
]

{ #category : #tests }
FlattenArrayTest >> test06_AllValuesInNestedListAreNull [
	| result |

	result := flattenArrayCalculator flattenArray: #(nil #(#(#(nil ) ) ) nil nil #(#(nil nil ) nil ) nil ) .
	self assert: result equals: #()
]
