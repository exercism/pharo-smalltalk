"
I override some of original Tonel Reader behavior. I skip source files containing comments only.
"
Class {
	#name : 'ExercismTonelReader',
	#superclass : 'TonelReader',
	#category : 'ExercismTools-Core',
	#package : 'ExercismTools',
	#tag : 'Core'
}

{ #category : 'private' }
ExercismTonelReader >> canBeLoaded: aFileReference [

	  ^ (super canBeLoaded: aFileReference) and: [
		 (self containsCommentsOnly: aFileReference) not 
		]
]

{ #category : 'as yet unclassified' }
ExercismTonelReader >> containsCommentsOnly: aFileReference [

	|fileContents|
	fileContents := aFileReference readStream copy contents.
	^ (TonelParser new removeComments: fileContents) trimBoth isEmpty
]
