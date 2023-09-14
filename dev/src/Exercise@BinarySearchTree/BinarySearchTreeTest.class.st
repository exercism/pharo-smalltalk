"
# BinarySearchTree

# Description

Insert and search for numbers in a binary tree.

When we need to represent sorted data, an array does not make a good data structure.

Say we have the array `[1, 3, 4, 5]`, and we add 2 to it so it becomes `[1, 3, 4, 5, 2]`.
Now we must sort the entire array again!
We can improve on this by realizing that we only need to make space for the new item `[1, nil, 3, 4, 5]`, and then adding the item in the space we added.
But this still requires us to shift many elements down by one.

Binary Search Trees, however, can operate on sorted data much more efficiently.

A binary search tree consists of a series of connected nodes.
Each node contains a piece of data (e.g. the number 3), a variable named `left`, and a variable named `right`.
The `left` and `right` variables point at `nil`, or other nodes.
Since these other nodes in turn have other nodes beneath them, we say that the left and right variables are pointing at subtrees.
All data in the left subtree is less than or equal to the current node's data, and all data in the right subtree is greater than the current node's data.

For example, if we had a node containing the data 4, and we added the data 2, our tree would look like this:

      4
     /
    2

If we then added 6, it would look like this:

      4
     / \
    2   6

If we then added 3, it would look like this

       4
     /   \
    2     6
     \
      3

And if we then added 1, 5, and 7, it would look like this

          4
        /   \
       /     \
      2       6
     / \     / \
    1   3   5   7

## Hint

Yo may want to use objects of the same class that represent tree and subtrees (nodes). Try to use recursion method for adding and sorting nodes.

"
Class {
	#name : #BinarySearchTreeTest,
	#superclass : #ExercismTest,
	#instVars : [
		'binarySearchTreeCalculator'
	],
	#category : #'Exercise@BinarySearchTree'
}

{ #category : #config }
BinarySearchTreeTest class >> exercise [
	
	^(ExercismExercise for: self) 
		isCore: false;
		isAutoApproved: true;
		difficulty: 6;
		topics: #('algorithms' 'conditionals' 'data_structures' 'recursion');
		yourself
]

{ #category : #config }
BinarySearchTreeTest class >> uuid [
	"Answer a unique id for this exercise"
	^'4f8a2a30-3bb5-4ed6-9304-5fd7211dd77d'
]

{ #category : #config }
BinarySearchTreeTest class >> version [
	"Generated from specification: 13 September 2023"
	^'Not specified'
]

{ #category : #running }
BinarySearchTreeTest >> setUp [
	super setUp.
	binarySearchTreeCalculator := BinarySearchTree new
]

{ #category : #tests }
BinarySearchTreeTest >> test01_DataIsRetained [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'data is retained'>
	<exeTestUUID: 'e9c93a78-c536-4750-a336-94583d23fafa'>

	| result |

	result := binarySearchTreeCalculator treeData: #('4').
	self assert: result data equals: '4'.
	self assert: result right isNil.
	self assert: result left isNil.
	
]

{ #category : #tests }
BinarySearchTreeTest >> test02_InsertDataAtProperNodeSmallerNumberAtLeftNode [
	<exeTestName: 'smaller number at left node'>
	<exeTestUUID: '7a95c9e8-69f6-476a-b0c4-4170cb3f7c91'>

	| result |

	result := binarySearchTreeCalculator treeData: #('4' '2').
	self assert: result data equals: '4'.
	self assert: result right isNil. 
	self assert: result left data equals: '2'.
	self assert: result left right isNil.	
	self assert: result left left isNil.
]

{ #category : #tests }
BinarySearchTreeTest >> test03_InsertDataAtProperNodeSameNumberAtLeftNode [
	<exeTestName: 'same number at left node'>
	<exeTestUUID: '22b89499-9805-4703-a159-1a6e434c1585'>

	| result |

	result := binarySearchTreeCalculator treeData: #('4' '4').
	self assert: result data equals: '4'.
	self assert: result right isNil.
	self assert: result left data equals: '4'.
	self assert: result left right isNil.
	self assert: result left left isNil.
]

{ #category : #tests }
BinarySearchTreeTest >> test04_InsertDataAtProperNodeGreaterNumberAtRightNode [
	<exeTestName: 'greater number at right node'>
	<exeTestUUID: '2e85fdde-77b1-41ed-b6ac-26ce6b663e34'>

	| result |

	result := binarySearchTreeCalculator treeData: #('4' '5') .
	self assert: result data equals: '4'.
	self assert: result right data equals: '5'.
	self assert: result right right isNil.
	self assert: result right left isNil.
	self assert: result left isNil.
]

{ #category : #tests }
BinarySearchTreeTest >> test05_CanCreateComplexTree [
	<exeTestName: 'can create complex tree'>
	<exeTestUUID: 'dd898658-40ab-41d0-965e-7f145bf66e0b'>

	| result |

	result := binarySearchTreeCalculator treeData: #('4' '2' '6' '1' '3' '5' '7').
	self assert: result data equals: '4'.
	self assert: result right data equals: '6'.
	self assert: result right right data equals: '7'.
	self assert: result right right right isNil.
	self assert: result right right left isNil.
	self assert: result right left data equals: '5'.
	self assert: result right left right isNil.
	self assert: result right left left isNil.
	self assert: result left data equals: '2'.
	self assert: result left right data equals: '3'.
	self assert: result left right right isNil.
	self assert: result left right left isNil.
	self assert: result left left data equals: '1'.
	self assert: result left left right isNil.
	self assert: result left left left isNil.

]

{ #category : #tests }
BinarySearchTreeTest >> test06_CanSortDataCanSortSingleNumber [
	<exeTestName: 'can sort single number'>
	<exeTestUUID: '9e0c06ef-aeca-4202-b8e4-97f1ed057d56'>

	| result |

	result := binarySearchTreeCalculator treeData: #('2') .
	self assert: result sortedData equals: #('2')
]

{ #category : #tests }
BinarySearchTreeTest >> test07_CanSortDataCanSortIfSecondNumberIsSmallerThanFirst [
	<exeTestName: 'can sort if second number is smaller than first'>
	<exeTestUUID: '425e6d07-fceb-4681-a4f4-e46920e380bb'>

	| result |

	result := binarySearchTreeCalculator treeData: #('2' '1') .
	self assert: result sortedData equals: #('1' '2')
]

{ #category : #tests }
BinarySearchTreeTest >> test08_CanSortDataCanSortIfSecondNumberIsSameAsFirst [
	<exeTestName: 'can sort if second number is same as first'>
	<exeTestUUID: 'bd7532cc-6988-4259-bac8-1d50140079ab'>

	| result |

	result := binarySearchTreeCalculator treeData: #('2' '2') .
	self assert: result sortedData equals: #('2' '2')
]

{ #category : #tests }
BinarySearchTreeTest >> test09_CanSortDataCanSortIfSecondNumberIsGreaterThanFirst [
	<exeTestName: 'can sort if second number is greater than first'>
	<exeTestUUID: 'b6d1b3a5-9d79-44fd-9013-c83ca92ddd36'>

	| result |

	result := binarySearchTreeCalculator treeData: #('2' '3') .
	self assert: result sortedData equals: #('2' '3')
]

{ #category : #tests }
BinarySearchTreeTest >> test10_CanSortDataCanSortComplexTree [
	<exeTestName: 'can sort complex tree'>
	<exeTestUUID: 'd00ec9bd-1288-4171-b968-d44d0808c1c8'>

	| result |

	result := binarySearchTreeCalculator treeData: #('2' '1' '3' '6' '7' '5') .
	self assert: result sortedData equals: #('1' '2' '3' '5' '6' '7')
]
