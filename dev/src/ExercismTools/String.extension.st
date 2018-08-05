Extension { #name : #String }

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
