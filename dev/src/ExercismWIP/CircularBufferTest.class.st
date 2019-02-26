"
# Circular Buffer

A circular buffer, cyclic buffer or ring buffer is a data structure that
uses a single, fixed-size buffer as if it were connected end-to-end.

A circular buffer first starts empty and of some predefined length. For
example, this is a 7-element buffer:

    [ ][ ][ ][ ][ ][ ][ ]

Assume that a 1 is written into the middle of the buffer (exact starting
location does not matter in a circular buffer):

    [ ][ ][ ][1][ ][ ][ ]

Then assume that two more elements are added — 2 & 3 — which get
appended after the 1:

    [ ][ ][ ][1][2][3][ ]

If two elements are then removed from the buffer, the oldest values
inside the buffer are removed. The two elements removed, in this case,
are 1 & 2, leaving the buffer with just a 3:

    [ ][ ][ ][ ][ ][3][ ]

If the buffer has 7 elements then it is completely full:

    [6][7][8][9][3][4][5]

When the buffer is full an error will be raised, alerting the client
that further writes are blocked until a slot becomes free.

When the buffer is full, the client can opt to overwrite the oldest
data with a forced write. In this case, two more elements — A & B —
are added and they overwrite the 3 & 4:

    [6][7][8][9][A][B][5]

3 & 4 have been replaced by A & B making 5 now the oldest data in the
buffer. Finally, if two elements are removed then what would be
returned is 5 & 6 yielding the buffer:

    [ ][7][8][9][A][B][ ]

Because there is space available, if the client again uses overwrite
to store C & D then the space where 5 & 6 were stored previously will
be used not the location of 7 & 8. 7 is still the oldest element and
the buffer is once again full.

    [D][7][8][9][A][B][C]

## Hint

TBD

"
Class {
	#name : #CircularBufferTest,
	#superclass : #ExercismTest,
	#instVars : [
		'circularBufferCalculator'
	],
	#category : #'ExercismWIP-CircularBuffer'
}

{ #category : #config }
CircularBufferTest class >> uuid [
	"Answer a unique id for this exercise"
	^'e4141fda-2b3f-0d00-a2f6-335809f0590c'
]

{ #category : #config }
CircularBufferTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
CircularBufferTest >> setUp [
	circularBufferCalculator := CircularBuffer new
]

{ #category : #test }
CircularBufferTest >> testAReadFreesUpCapacityForAnotherWrite [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); at: 3 put: ((Dictionary new) add: ('item'->2); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 4 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->2); add: ('operation'->'read'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testCanReadAnItemJustWritten [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testClearDoesNothingOnEmptyBuffer [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('operation'->'clear'); yourself); at: 2 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 3 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testClearFreesUpCapacityForAnotherWrite [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'clear'); yourself); at: 3 put: ((Dictionary new) add: ('item'->2); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 4 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->2); add: ('operation'->'read'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testEachItemMayOnlyBeReadOnce [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); at: 3 put: ((Dictionary new) add: ('should_succeed'->false); add: ('operation'->'read'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testFullBufferCantBeWrittenTo [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 2) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('item'->2); add: ('should_succeed'->false); add: ('operation'->'write'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testItemsAreReadInTheOrderTheyAreWritten [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('item'->2); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 3 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); at: 4 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->2); add: ('operation'->'read'); yourself); yourself) capacity: 2 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testItemsClearedOutOfBufferCantBeRead [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 3) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('operation'->'clear'); yourself); at: 3 put: ((Dictionary new) add: ('should_succeed'->false); add: ('operation'->'read'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testOverwriteActsLikeWriteOnNonfullBuffer [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 4) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('item'->2); add: ('operation'->'overwrite'); yourself); at: 3 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); at: 4 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->2); add: ('operation'->'read'); yourself); yourself) capacity: 2 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testOverwriteReplacesTheOldestItemOnFullBuffer [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 5) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('item'->2); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 3 put: ((Dictionary new) add: ('item'->3); add: ('operation'->'overwrite'); yourself); at: 4 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->2); add: ('operation'->'read'); yourself); at: 5 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->3); add: ('operation'->'read'); yourself); yourself) capacity: 2 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testOverwriteReplacesTheOldestItemRemainingInBufferFollowingARead [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 9) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('item'->2); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 3 put: ((Dictionary new) add: ('item'->3); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 4 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); at: 5 put: ((Dictionary new) add: ('item'->4); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 6 put: ((Dictionary new) add: ('item'->5); add: ('operation'->'overwrite'); yourself); at: 7 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->3); add: ('operation'->'read'); yourself); at: 8 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->4); add: ('operation'->'read'); yourself); at: 9 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->5); add: ('operation'->'read'); yourself); yourself) capacity: 3 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testReadPositionIsMaintainedEvenAcrossMultipleWrites [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 6) at: 1 put: ((Dictionary new) add: ('item'->1); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 2 put: ((Dictionary new) add: ('item'->2); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 3 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->1); add: ('operation'->'read'); yourself); at: 4 put: ((Dictionary new) add: ('item'->3); add: ('should_succeed'->true); add: ('operation'->'write'); yourself); at: 5 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->2); add: ('operation'->'read'); yourself); at: 6 put: ((Dictionary new) add: ('should_succeed'->true); add: ('expected'->3); add: ('operation'->'read'); yourself); yourself) capacity: 3 .
	self assert: result equals: ((Dictionary new))
]

{ #category : #test }
CircularBufferTest >> testReadingEmptyBufferShouldFail [
	| result |

	result := circularBufferCalculator runOperations: ((Array new: 1) at: 1 put: ((Dictionary new) add: ('should_succeed'->false); add: ('operation'->'read'); yourself); yourself) capacity: 1 .
	self assert: result equals: ((Dictionary new))
]
