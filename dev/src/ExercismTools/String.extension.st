Extension { #name : #String }

{ #category : #'*ExercismTools' }
String >> ->> aCollectionOfAssociations [
	"Similar to -> but converts aCollection to anOrderedDictionary, useful when building JSON structures"

	^self -> aCollectionOfAssociations asOrderedDictionary 
]

{ #category : #'*ExercismTools' }
String >> asKebabCase [
	"Answer a String that converts the CamelCase input to camel-case kebab output 
	used by exercism"

	^ self class
		streamContents: [ :kebabStream |
			self uncapitalized
				do: [ :char |
					char isUppercase
						ifTrue: [ kebabStream nextPut: $- ].
					kebabStream nextPut: char asLowercase ] ]
]

{ #category : #'*ExercismTools' }
String >> exPathString [
	"Answer the receiver as a valid path, with a trailing /"

	^ String
		streamContents: [ :s | 
			s nextPutAll: self.
			self last = $/
				ifFalse: [ s nextPut: $/ ] ]
]

{ #category : #'*ExercismTools' }
String >> kebabAsCamelCase [
	"Answer a String that converts the CamelCase input to camel-case kebab output 
	used by exercism"

	^ (self copyReplaceAll: {$-} with: {Character space}) asCamelCase.
]
