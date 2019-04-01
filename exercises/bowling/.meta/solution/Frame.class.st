"
I am the frame calculations for a bowling throw
"
Class {
	#name : #Frame,
	#superclass : #Object,
	#instVars : [
		'roll1',
		'roll2',
		'bonus'
	],
	#category : #'Exercism-Bowling'
}

{ #category : #accessing }
Frame >> beSpareBonus [
	bonus := #spare
]

{ #category : #accessing }
Frame >> beStrikeBonus [
	bonus := #strike
]

{ #category : #initialization }
Frame >> initialize [
	bonus := false
]

{ #category : #testing }
Frame >> isBonus [
	^ bonus = #spare or: [ bonus = #strike ]
]

{ #category : #testing }
Frame >> isFinished [
	^ self isStrike
		or: [ self isSpare
			or: [ self isOpen
				or: [ (bonus = #spare and: [ roll1 isNotNil ])
					or: [ (bonus = #strike and: [ roll1 isNotNil & roll2 isNotNil ]) ] ] ] ]
]

{ #category : #testing }
Frame >> isOpen [
	^ roll1 ~= 10
		and: [ roll1 isNotNil
			and: [ roll2 isNotNil
				and: [ roll1 + roll2 ~= 10 ] ] ]
]

{ #category : #testing }
Frame >> isSpare [
	^ self isBonus not
		and: [ roll1 ~= 10
			and: [ roll1 isNotNil
				and: [ roll2 isNotNil
					and: [ roll1 + roll2 = 10 ] ] ] ]
]

{ #category : #testing }
Frame >> isStrike [
	^ self isBonus not
		and: [ roll1 = 10 ]
]

{ #category : #rolling }
Frame >> roll: anInteger [
	roll1
		ifNil: [ roll1 := anInteger ]
		ifNotNil: [
			((self isBonus not) & (roll1 + anInteger > 10))
			| ((bonus = #strike) & (roll1 ~= 10) & (roll1 + anInteger > 10))
				ifTrue: [ self error: 'Pin count exceeds pins on the lane' ].
			roll2 := anInteger ]
]

{ #category : #accessing }
Frame >> rolls [
	^ roll1
		ifNil: [ #() ]
		ifNotNil: [
			roll2
				ifNil: [ { roll1 } ]
				ifNotNil: [ { roll1. roll2 } ] ]
]

{ #category : #accessing }
Frame >> score [
	^ roll1 + (roll2 ifNil: [ 0 ])
]
