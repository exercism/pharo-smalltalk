"
I iterate through a list of associations to check the factor and obtain the correct rain noise.
"
Class {
	#name : #Raindrops,
	#superclass : #Object,
	#category : #'Exercism-Raindrops'
}

{ #category : #exercism }
Raindrops >> convertNumber: aNumber [

	^ String
		streamContents: [ :stream | 
			{(3 -> 'Pling'). (5 -> 'Plang'). (7 -> 'Plong')} 
				do: [ :factor | 
					aNumber \\ factor key = 0
						ifTrue: [ stream nextPutAll: factor value ] ].
					
			stream isEmpty
				ifTrue: [ stream print: aNumber ] ]
]
