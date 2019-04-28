"
I am a simple match result tally, that holds the number of wins, losses and draws for a team.
"
Class {
	#name : #ResultTally,
	#superclass : #Object,
	#instVars : [
		'tallys',
		'name'
	],
	#category : #'Exercism@Tournament'
}

{ #category : #'instance creation' }
ResultTally class >> for: nameString [
	^self new name: nameString; yourself
]

{ #category : #counting }
ResultTally >> countOutcome: aString [
	| tally |

	tally := self tallys at: aString ifAbsent: [ 0 ].
	self tallys at: aString put: tally + 1
]

{ #category : #accessing }
ResultTally >> draws [
	^ self tallys at: 'draw' ifAbsent: [ 0 ]
]

{ #category : #accessing }
ResultTally >> losses [
	^ self tallys at: 'loss' ifAbsent: [ 0 ]
]

{ #category : #accessing }
ResultTally >> matchesPlayed [
	^ self wins + self losses + self draws
]

{ #category : #accessing }
ResultTally >> name [
	^ name
]

{ #category : #accessing }
ResultTally >> name: nameString [
	name := nameString
]

{ #category : #printing }
ResultTally >> outputResultOn: aWriteStream [
	aWriteStream
		nextPutAll: (self name padRightTo: 31);
		nextPutAll:
			('|  {1} |  {2} |  {3} |  {4} |  {5}'
				format:
					{self matchesPlayed.
					self wins.
					self draws.
					self losses.
					self points});
		cr
]

{ #category : #accessing }
ResultTally >> points [
	^ self wins * 3 + self draws
]

{ #category : #accessing }
ResultTally >> tallys [
	^ tallys ifNil: [ tallys := Dictionary new ]
]

{ #category : #accessing }
ResultTally >> wins [
	^self tallys at: 'win' ifAbsent: [  0 ]
]
