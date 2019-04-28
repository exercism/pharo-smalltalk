"
I am a simple tournament league table, that maintains a collection of ResultTally's to display match statistics.
"
Class {
	#name : #Tournament,
	#superclass : #Object,
	#instVars : [
		'results'
	],
	#classVars : [
		'OutcomeTable'
	],
	#category : #'Exercism@Tournament'
}

{ #category : #config }
Tournament class >> outcomeInverse [
	^OutcomeTable ifNil: [ OutcomeTable := { 'win'->'loss'. 'loss'->'win'. 'draw'->'draw'} asDictionary ]
]

{ #category : #helper }
Tournament >> addResultFor: teamString outcome: outcomeString [
	| tally |

	tally := self results
		at: teamString
		ifAbsentPut: [ ResultTally for: teamString ].

	tally countOutcome: outcomeString
]

{ #category : #helper }
Tournament >> inverseOutcome: matchStatus [
	"Answer the opposite outcome string to @matchStatus, e.g. win -> loss"

	^self class outcomeInverse at: matchStatus
	
]

{ #category : #printing }
Tournament >> outputResultHeaderOn: aWriteStream [
	aWriteStream
		nextPutAll: 'Team                           | MP |  W |  D |  L |  P';
		cr
]

{ #category : #printing }
Tournament >> outputTallyResultsOn: writeStream [
	| sortedResults |

	sortedResults := self results
		asSortedCollection: [ :teamA :teamB | 
			teamA points > teamB points
				or: [ teamA points = teamB points and: [ teamA name <= teamB name ] ] ].

	sortedResults do: [ :tally | tally outputResultOn: writeStream ]
]

{ #category : #helper }
Tournament >> parseMatchLine: aString [
	"Parse the match line items, seperated by ; and Answer a collection in the form of:
		#(teamA outcome teamB oppositeOutome)"
		
	| parts |

	parts := $; split: aString.
	^ Array
		with: parts first
		with: parts third
		with: parts second
		with: (self inverseOutcome: parts last)
]

{ #category : #acccessing }
Tournament >> results [
	^results ifNil: [ results := Dictionary new ]
]

{ #category : #exercism }
Tournament >> tallyRows: rowCollection [
	rowCollection
		do: [ :line | 
			(self parseMatchLine: line)
				pairsDo: [ :name :outcome | self addResultFor: name outcome: outcome ] ].

	^ (String
		streamContents: [ :output | 
			self
				outputResultHeaderOn: output;
				outputTallyResultsOn: output ]) lines
]
