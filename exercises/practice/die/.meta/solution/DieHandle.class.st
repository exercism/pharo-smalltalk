"
I represent a handle of dice.
I can roll and I can be added to other handles.

A dieHandle can be created using a dunjon and dragon syntax:
	2 D20 means two dice with 20 faces. 
	
2 D20 + 3 D4
Means that I should roll 5 dices.


"
Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'Exercise@Die'
}

{ #category : #adding }
DieHandle >> + aDieHandle [
	"Returns a new handle that represents the addition of the receiver and the argument."
	| handle |
	handle := self class new.
	dice do: [ :each | handle addDie: each ].
	aDieHandle dice do: [ :each | handle addDie: each ].
	^ handle
]

{ #category : #adding }
DieHandle >> addDie: aDie [

	dice add: aDie
]

{ #category : #accessing }
DieHandle >> dice [ 

	^ dice
]

{ #category : #accessing }
DieHandle >> diceNumber [ 

	^ dice size
]

{ #category : #initialization }
DieHandle >> initialize [
	super initialize.
	dice := OrderedCollection new
]

{ #category : #rolling }
DieHandle >> roll [

	| res |
	res := 0.
	dice do: [ :each | res := res + each roll ].
	^ res 
]
