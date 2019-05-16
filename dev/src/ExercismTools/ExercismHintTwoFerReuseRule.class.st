"
The TwoFer exercise introduces you to calling between methods.
For practice, your '#who'  method should reuse your  '#who:'  method. 
"
Class {
	#name : #ExercismHintTwoFerReuseRule,
	#superclass : #ExercismHintRule,
	#category : #ExercismTools
}

{ #category : #'testing-interest' }
ExercismHintTwoFerReuseRule class >> checksMethod [
	^true
]

{ #category : #accessing }
ExercismHintTwoFerReuseRule >> basicCheck: compiledMethod [
	compiledMethod methodClass name = #TwoFer ifTrue: [ 
		|literals|
		literals := compiledMethod sourceCode parseLiterals.
		literals first = #who ifTrue: [ ^ (literals includes: #who:) not ].
		].
	^false

]

{ #category : #accessing }
ExercismHintTwoFerReuseRule >> name [
	^ 'Exercism: Method #who should reuse method #who: '
]
