"
I represent a die. I can have different faces number and roll. 

"
Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'Exercise@Die'
}

{ #category : #'instance creation' }
Die class >> withFaces: anInteger [ 
	^ self new faces: anInteger ; yourself
]

{ #category : #accessing }
Die >> faces [

	^ faces
]

{ #category : #accessing }
Die >> faces: aNumber [ 

	faces := aNumber
]

{ #category : #initialization }
Die >> initialize [
	super initialize.
	faces := 6
]

{ #category : #printing }
Die >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' ('.
	aStream print: faces. 
	aStream nextPutAll: ')'

]

{ #category : #rolling }
Die >> roll [ 

	^ faces atRandom 
]
