"
I maintain a list of bowling Frames and answer the scoring
"
Class {
	#name : 'Bowling',
	#superclass : 'Object',
	#instVars : [
		'frames',
		'currentFrame'
	],
	#category : 'Exercise@Bowling',
	#package : 'Exercise@Bowling'
}

{ #category : 'rolling' }
Bowling >> checkRoll: anInteger [
	anInteger < 0
		ifTrue: [ self error: 'Negative roll is invalid' ].
	anInteger > 10
		ifTrue: [ self error: 'Pin count exceeds pins on the lane' ].
	self isFinished
		ifTrue: [ self error: 'Cannot roll after game is over' ]
]

{ #category : 'initialization' }
Bowling >> initialize [
	currentFrame := Frame new.
	frames := OrderedCollection new

]

{ #category : 'testing' }
Bowling >> isFinished [
	^ (frames size = 10 and: [ frames last isOpen ])
			or: [ (frames size = 11 and: [ frames last isFinished ]) ]
]

{ #category : 'rolling' }
Bowling >> roll: pinCount [
	self checkRoll: pinCount.
	currentFrame roll: pinCount.
	currentFrame isFinished
		ifFalse: [ ^ self ].
		
	frames add: currentFrame.
	currentFrame := Frame new.
	frames size = 10
		ifFalse: [ ^ self ].
		
	frames last isStrike
		ifTrue: [ currentFrame beStrikeBonus ].
	frames last isSpare
		ifTrue: [ currentFrame beSpareBonus ]
]

{ #category : 'accessing' }
Bowling >> score [
	| result |

	self isFinished
		ifFalse: [ self error: 'Score cannot be taken until the end of the game' ].
	result := 0.
	frames
		doWithIndex: [ :each :index | 
			result := result + each score.
			each isSpare
				ifTrue: [
					result := result + (frames at: index + 1) rolls first.
					index = 10 ifTrue: [ ^ result ] ].
			each isStrike
				ifTrue: [
					result := result + (frames at: index + 1) score.
					(frames at: index + 1) isStrike
						ifTrue: [ result := result + (frames at: index + 2) rolls first ].
					index = 10 ifTrue: [ ^ result ] ] ].
	^ result
]

{ #category : 'exercism' }
Bowling >> scoreAfterRolling: countCollection [ 
	countCollection do: [ :pinCount | self roll: pinCount ].
	^self score
]

{ #category : 'exercism' }
Bowling >> scoreRolling: pinCount after: countCollection [ 
	^self scoreAfterRolling: (countCollection copyWith: pinCount)
]
