Class {
	#name : #Raindrops,
	#superclass : #Object,
	#category : #'Exercism-Raindrops'
}

{ #category : #exercism }
Raindrops >> convertNumber: aNumber [ 
	| output |
	output := WriteStream on: ''.
	
	{ 3-> 'Pling'. 5->'Plang'. 7->'Plong' } do: [ :factor |
		aNumber \\ factor key = 0 ifTrue: [ output nextPutAll: factor value ]].
			
	output isEmpty ifTrue: [ output print: aNumber ].
	
	^output contents
]
