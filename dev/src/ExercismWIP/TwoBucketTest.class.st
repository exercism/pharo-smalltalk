"
# Two Bucket

Given two buckets of different size, demonstrate how to measure an exact number of liters by strategically transferring liters of fluid between the buckets.

Since this mathematical problem is fairly subject to interpretation / individual approach, the tests have been written specifically to expect one overarching solution.

To help, the tests provide you with which bucket to fill first. That means, when starting with the larger bucket full, you are NOT allowed at any point to have the smaller bucket full and the larger bucket empty (aka, the opposite starting point); that would defeat the purpose of comparing both approaches!

Your program will take as input:
- the size of bucket one
- the size of bucket two
- the desired number of liters to reach
- which bucket to fill first, either bucket one or bucket two

Your program should determine:
- the total number of ""moves"" it should take to reach the desired number of liters, including the first fill
- which bucket should end up with the desired number of liters (let's say this is bucket A) - either bucket one or bucket two
- how many liters are left in the other bucket (bucket B)

Note: any time a change is made to either or both buckets counts as one (1) move.

Example:
Bucket one can hold up to 7 liters, and bucket two can hold up to 11 liters. Let's say bucket one, at a given step, is holding 7 liters, and bucket two is holding 8 liters (7,8). If you empty bucket one and make no change to bucket two, leaving you with 0 liters and 8 liters respectively (0,8), that counts as one ""move"". Instead, if you had poured from bucket one into bucket two until bucket two was full, leaving you with 4 liters in bucket one and 11 liters in bucket two (4,11), that would count as only one ""move"" as well.

To conclude, the only valid moves are:
- pouring from one bucket to another
- emptying one bucket and doing nothing to the other
- filling one bucket and doing nothing to the other

Written with <3 at [Fullstack Academy](http://www.fullstackacademy.com/) by Lindsay Levine.

## Hint

TBD

"
Class {
	#name : #TwoBucketTest,
	#superclass : #ExercismTest,
	#instVars : [
		'twoBucketCalculator'
	],
	#category : #'ExercismWIP-TwoBucket'
}

{ #category : #config }
TwoBucketTest class >> uuid [
	"Answer a unique id for this exercise"
	^'d4a2dbd9-2b3f-0d00-a2b3-430c09f0590c'
]

{ #category : #config }
TwoBucketTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.4.0'
]

{ #category : #setup }
TwoBucketTest >> setUp [
	twoBucketCalculator := TwoBucket new
]

{ #category : #test }
TwoBucketTest >> testMeasureOneStepUsingBucketOneOfSize1AndBucketTwoOfSize3StartWithBucketTwo [
	| result |

	result := twoBucketCalculator measureGoal: 3 bucketTwo: 3 startBucket: 'two' bucketOne: 1 .
	self assert: result equals: ((Dictionary new) add: ('goalBucket'->'two'); add: ('otherBucket'->0); add: ('moves'->1); yourself)
]

{ #category : #test }
TwoBucketTest >> testMeasureUsingBucketOneOfSize2AndBucketTwoOfSize3StartWithBucketOneAndEndWithBucketTwo [
	| result |

	result := twoBucketCalculator measureGoal: 3 bucketTwo: 3 startBucket: 'one' bucketOne: 2 .
	self assert: result equals: ((Dictionary new) add: ('goalBucket'->'two'); add: ('otherBucket'->2); add: ('moves'->2); yourself)
]

{ #category : #test }
TwoBucketTest >> testMeasureUsingBucketOneOfSize3AndBucketTwoOfSize5StartWithBucketOne [
	| result |

	result := twoBucketCalculator measureGoal: 1 bucketTwo: 5 startBucket: 'one' bucketOne: 3 .
	self assert: result equals: ((Dictionary new) add: ('goalBucket'->'one'); add: ('otherBucket'->5); add: ('moves'->4); yourself)
]

{ #category : #test }
TwoBucketTest >> testMeasureUsingBucketOneOfSize3AndBucketTwoOfSize5StartWithBucketTwo [
	| result |

	result := twoBucketCalculator measureGoal: 1 bucketTwo: 5 startBucket: 'two' bucketOne: 3 .
	self assert: result equals: ((Dictionary new) add: ('goalBucket'->'two'); add: ('otherBucket'->3); add: ('moves'->8); yourself)
]

{ #category : #test }
TwoBucketTest >> testMeasureUsingBucketOneOfSize7AndBucketTwoOfSize11StartWithBucketOne [
	| result |

	result := twoBucketCalculator measureGoal: 2 bucketTwo: 11 startBucket: 'one' bucketOne: 7 .
	self assert: result equals: ((Dictionary new) add: ('goalBucket'->'one'); add: ('otherBucket'->11); add: ('moves'->14); yourself)
]

{ #category : #test }
TwoBucketTest >> testMeasureUsingBucketOneOfSize7AndBucketTwoOfSize11StartWithBucketTwo [
	| result |

	result := twoBucketCalculator measureGoal: 2 bucketTwo: 11 startBucket: 'two' bucketOne: 7 .
	self assert: result equals: ((Dictionary new) add: ('goalBucket'->'two'); add: ('otherBucket'->7); add: ('moves'->18); yourself)
]
