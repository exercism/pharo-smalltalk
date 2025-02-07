"
# Circular Buffer

# Description

A circular buffer, cyclic buffer or ring buffer is a data structure that uses a single, fixed-size buffer as if it were connected end-to-end.

A circular buffer first starts empty and of some predefined length.
For example, this is a 7-element buffer:
<!-- prettier-ignore -->
    [ ][ ][ ][ ][ ][ ][ ]

Assume that a 1 is written into the middle of the buffer (exact starting location does not matter in a circular buffer):
<!-- prettier-ignore -->
    [ ][ ][ ][1][ ][ ][ ]

Then assume that two more elements are added — 2 & 3 — which get appended after the 1:
<!-- prettier-ignore -->
    [ ][ ][ ][1][2][3][ ]

If two elements are then removed from the buffer, the oldest values inside the buffer are removed.
The two elements removed, in this case, are 1 & 2, leaving the buffer with just a 3:
<!-- prettier-ignore -->
    [ ][ ][ ][ ][ ][3][ ]

If the buffer has 7 elements then it is completely full:
<!-- prettier-ignore -->
    [5][6][7][8][9][3][4]

When the buffer is full an error will be raised, alerting the client that further writes are blocked until a slot becomes free.

When the buffer is full, the client can opt to overwrite the oldest data with a forced write.
In this case, two more elements — A & B — are added and they overwrite the 3 & 4:
<!-- prettier-ignore -->
    [5][6][7][8][9][A][B]

3 & 4 have been replaced by A & B making 5 now the oldest data in the buffer.
Finally, if two elements are removed then what would be returned is 5 & 6 yielding the buffer:
<!-- prettier-ignore -->
    [ ][ ][7][8][9][A][B]

Because there is space available, if the client again uses overwrite to store C & D then the space where 5 & 6 were stored previously will be used not the location of 7 & 8.
7 is still the oldest element and the buffer is once again full.
<!-- prettier-ignore -->
    [C][D][7][8][9][A][B]

## Hint
For error cases during operations, see Error class hierarchy (class side) to find out how to signal exception with given message.

"
Class {
	#name : #CircularBufferTest,
	#superclass : #ExercismTest,
	#instVars : [
		'circularBufferCalculator'
	],
	#category : #'Exercise@CircularBuffer'
}

{ #category : #config }
CircularBufferTest class >> exercise [

	^(ExercismExercise for: self) 
		isCore: false;
		isAutoApproved: true;
		difficulty: 5;
		topics: #('arrays' 'conditionals' 'data_structures' 'exception_handling' 'lists' 'list-methods');
		yourself
]

{ #category : #config }
CircularBufferTest class >> uuid [
	"Answer a unique id for this exercise"
	^'158d4bc4-1002-4612-bdaf-5aa711a4f9a4'
]

{ #category : #config }
CircularBufferTest class >> version [
	"Generated from specification: 7 September 2023"
	^'Not specified'
]

{ #category : #running }
CircularBufferTest >> setUp [
	super setUp.
	circularBufferCalculator := CircularBuffer new
]

{ #category : #tests }
CircularBufferTest >> test01_ReadingEmptyBufferShouldFail [
	"Tip: Remember to review the class [Comment] tab"

	<exeTestName: 'reading empty buffer should fail'>
	<exeTestUUID: '28268ed4-4ff3-45f3-820e-895b44d53dfa'>
	circularBufferCalculator capacity: 1.
	self should: [circularBufferCalculator read] raise: Error.
]

{ #category : #tests }
CircularBufferTest >> test02_CanReadAnItemJustWritten [

	<exeTestName: 'can read an item just written'>
	<exeTestUUID: '2e6db04a-58a1-425d-ade8-ac30b5f318f3'>
	| result |
	circularBufferCalculator capacity: 1.
	circularBufferCalculator write: 1.
	result := circularBufferCalculator read.
	self assert: result equals: 1
]

{ #category : #tests }
CircularBufferTest >> test03_EachItemMayOnlyBeReadOnce [

	<exeTestName: 'each item may only be read once'>
	<exeTestUUID: '90741fe8-a448-45ce-be2b-de009a24c144'>
	| result |
	circularBufferCalculator capacity: 1.
	circularBufferCalculator write: 1.
	result := circularBufferCalculator read.
	self assert: result equals: 1.
	self should: [circularBufferCalculator read] raise: Error
]

{ #category : #tests }
CircularBufferTest >> test04_ItemsAreReadInTheOrderTheyAreWritten [

	<exeTestName: 'items are read in the order they are written'>
	<exeTestUUID: 'be0e62d5-da9c-47a8-b037-5db21827baa7'>
	| result |
	circularBufferCalculator capacity: 2.

	circularBufferCalculator write: 1.
	circularBufferCalculator write: 2.

	result := circularBufferCalculator read.
	self assert: result equals: 1.

	result := circularBufferCalculator read.
	self assert: result equals: 2
]

{ #category : #tests }
CircularBufferTest >> test05_FullBufferCantBeWrittenTo [

	<exeTestName: 'full buffer can''t be written to'>
	<exeTestUUID: '2af22046-3e44-4235-bfe6-05ba60439d38'>
	
	circularBufferCalculator capacity: 1.
	circularBufferCalculator write: 1.
	self should: [ circularBufferCalculator write: 2 ] raise: Error
]

{ #category : #tests }
CircularBufferTest >> test06_AReadFreesUpCapacityForAnotherWrite [

	<exeTestName: 'a read frees up capacity for another write'>
	<exeTestUUID: '547d192c-bbf0-4369-b8fa-fc37e71f2393'>
	| result |
	circularBufferCalculator capacity: 1.

	circularBufferCalculator write: 1.
	result := circularBufferCalculator read.
	self assert: result equals: 1.

	circularBufferCalculator write: 2.
	result := circularBufferCalculator read.
	self assert: result equals: 2
]

{ #category : #tests }
CircularBufferTest >> test07_ReadPositionIsMaintainedEvenAcrossMultipleWrites [

	<exeTestName: 'read position is maintained even across multiple writes'>
	<exeTestUUID: '04a56659-3a81-4113-816b-6ecb659b4471'>
	| result |
	circularBufferCalculator capacity: 3.

	circularBufferCalculator write: 1.
	circularBufferCalculator write: 2.

	result := circularBufferCalculator read.
	self assert: result equals: 1.

	circularBufferCalculator write: 3.

	result := circularBufferCalculator read.
	self assert: result equals: 2.

	result := circularBufferCalculator read.
	self assert: result equals: 3
]

{ #category : #tests }
CircularBufferTest >> test08_ItemsClearedOutOfBufferCantBeRead [

	<exeTestName: 'items cleared out of buffer can''t be read'>
	<exeTestUUID: '60c3a19a-81a7-43d7-bb0a-f07242b1111f'>

	circularBufferCalculator capacity: 1.
	circularBufferCalculator write: 1.
	circularBufferCalculator clear.

	self should: [ circularBufferCalculator read ] raise: Error
]

{ #category : #tests }
CircularBufferTest >> test09_ClearFreesUpCapacityForAnotherWrite [

	<exeTestName: 'clear frees up capacity for another write'>
	<exeTestUUID: '45f3ae89-3470-49f3-b50e-362e4b330a59'>
	| result |
	circularBufferCalculator capacity: 1.
	circularBufferCalculator write: 1.
	
	circularBufferCalculator clear.

	circularBufferCalculator write: 2.

	result := circularBufferCalculator read.
	self assert: result equals: 2
]

{ #category : #tests }
CircularBufferTest >> test10_ClearDoesNothingOnEmptyBuffer [

	<exeTestName: 'clear does nothing on empty buffer'>
	<exeTestUUID: 'e1ac5170-a026-4725-bfbe-0cf332eddecd'>
	| result |
	circularBufferCalculator capacity: 1.
	circularBufferCalculator clear.

	circularBufferCalculator write: 1.

	result := circularBufferCalculator read.
	self assert: result equals: 1
]

{ #category : #tests }
CircularBufferTest >> test11_OverwriteActsLikeWriteOnNonfullBuffer [

	<exeTestName: 'overwrite acts like write on non-full buffer'>
	<exeTestUUID: '9c2d4f26-3ec7-453f-a895-7e7ff8ae7b5b'>
	| result |
	circularBufferCalculator capacity: 2.
	circularBufferCalculator write: 1.
	circularBufferCalculator overwrite: 2.

	result := circularBufferCalculator read.
	self assert: result equals: 1.

	result := circularBufferCalculator read.
	self assert: result equals: 2
]

{ #category : #tests }
CircularBufferTest >> test12_OverwriteReplacesTheOldestItemOnFullBuffer [

	<exeTestName: 'overwrite replaces the oldest item on full buffer'>
	<exeTestUUID: '880f916b-5039-475c-bd5c-83463c36a147'>
	| result |
	circularBufferCalculator capacity: 2.
	circularBufferCalculator write: 1.
	circularBufferCalculator write: 2.

	circularBufferCalculator overwrite: 3.

	result := circularBufferCalculator read.
	self assert: result equals: 2.

	result := circularBufferCalculator read.
	self assert: result equals: 3
]

{ #category : #tests }
CircularBufferTest >> test13_OverwriteReplacesTheOldestItemRemainingInBufferFollowingARead [

	<exeTestName: 'overwrite replaces the oldest item remaining in buffer following a read'>
	<exeTestUUID: 'bfecab5b-aca1-4fab-a2b0-cd4af2b053c3'>
	| result |
	circularBufferCalculator capacity: 3.

	circularBufferCalculator write: 1.
	circularBufferCalculator write: 2.
	circularBufferCalculator write: 3.


	result := circularBufferCalculator read.
	self assert: result equals: 1.

	circularBufferCalculator write: 4.
	circularBufferCalculator overwrite: 5.

	result := circularBufferCalculator read.
	self assert: result equals: 3.

	result := circularBufferCalculator read.
	self assert: result equals: 4.

	result := circularBufferCalculator read.
	self assert: result equals: 5
]

{ #category : #tests }
CircularBufferTest >> test14_InitialClearDoesNotAffectWrappingAround [

	<exeTestName: 'initial clear does not affect wrapping around'>
	<exeTestUUID: '9cebe63a-c405-437b-8b62-e3fdc1ecec5a'>
	| result |
	circularBufferCalculator capacity: 2.
	circularBufferCalculator clear.

	circularBufferCalculator write: 1.
	circularBufferCalculator write: 2.

	circularBufferCalculator overwrite: 3.
	circularBufferCalculator overwrite: 4.

	result := circularBufferCalculator read.
	self assert: result equals: 3.

	result := circularBufferCalculator read.
	self assert: result equals: 4.

	self should: [ circularBufferCalculator read ] raise: Error
]
