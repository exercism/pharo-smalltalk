"
I represent Simple Cipher, I do simple encoding/decoding based on either supplied or own generated key. I support operations encode, decode with input string parameter. Optionally, key can be passed, based on which encoding/decoding should happen.
"
Class {
	#name : 'SimpleCipher',
	#superclass : 'Object',
	#instVars : [
		'key',
		'alphabet'
	],
	#category : 'Exercise@SimpleCipher',
	#package : 'Exercise@SimpleCipher'
}

{ #category : 'accessing' }
SimpleCipher >> alphabet [
	
	"lowercase alphabet, it is cached since we do not want to create copies for every loop iteration"
	^ alphabet ifNil: [ alphabet := Character alphabet ]
]

{ #category : 'exercism' }
SimpleCipher >> decode: aString [
	
	^ aString withIndexCollect: [: char :idx| 
		self alphabet at: (self decodedIndexOf: char atKeyPosition: idx )
	]
]

{ #category : 'exercism' }
SimpleCipher >> decodedIndexOf: aChar atKeyPosition: keyPos [
	
		|idx|
		idx :=  (self alphabet indexOf: aChar) - (self keyDistanceAt: keyPos).
		idx < 1 ifTrue: [ ^ self alphabet size + idx ].
		^ idx
]

{ #category : 'exercism' }
SimpleCipher >> encode: aString [ 
	
	^ aString withIndexCollect: [: char :idx| 
		self alphabet at: (self encodedIndexOf: char atKeyPosition: idx )
	]
]

{ #category : 'exercism' }
SimpleCipher >> encodedIndexOf: aChar atKeyPosition: keyPos [
	
		|idx| 
		idx := (self alphabet indexOf: aChar) + (self keyDistanceAt: keyPos).
		idx > self alphabet size ifTrue: [ ^ idx \\ self alphabet size ].
		^ idx
]

{ #category : 'private' }
SimpleCipher >> generateRandomKey [

	| aKey |
	aKey := String new: 100.
	1 to: 100 do: [:idx | aKey at: idx put: self alphabet atRandom ].
	^ aKey
]

{ #category : 'accessing' }
SimpleCipher >> key [

	^ key ifNil: [ key := self generateRandomKey ]
]

{ #category : 'accessing' }
SimpleCipher >> key: lowerCaseString [

	key := lowerCaseString
]

{ #category : 'exercism' }
SimpleCipher >> keyDistanceAt: keyPos [
		|aPos|
		"use modulo to wrap index to size of key"
		aPos := keyPos \\ self key size. 
		
		"when current index of encoded/decoded letter is equal to size of key"
		aPos isZero ifTrue: [ aPos := self key size ]. 

		"returns for how many letters target letter should be shifted"
		^ (self alphabet indexOf: (self key at: aPos)) - 1
		
]
