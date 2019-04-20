Class {
	#name : #SecretHandshake,
	#superclass : #Object,
	#category : #'Exercism-SecretHandshake'
}

{ #category : #accessing }
SecretHandshake >> commandsNumber: anInteger [
	| handshake |
	handshake := Array
		streamContents: [ :aStream | 
			self secrets
				keysAndValuesDo: [ :secret :value | 
					(anInteger allMask: secret)
						ifTrue: [ aStream nextPut: value ] ] ].
	^ (anInteger allMask: 2r10000)
		ifTrue: [ handshake reversed ]
		ifFalse: [ handshake ]
]

{ #category : #accessing }
SecretHandshake >> secrets [
	^ OrderedDictionary new
		at: 2r1 put: 'wink';
		at: 2r10 put: 'double blink';
		at: 2r100 put: 'close your eyes';
		at: 2r1000 put: 'jump';
		yourself
]
