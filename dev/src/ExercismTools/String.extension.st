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
String >> encodeDoublingDoubleQuotesOn: s [
	"Print inside string quotes, doubling inbedded quotes."

	self
		do: [ :c | 
			c = $"
				ifTrue: [ s << $" ].
			s << c ]
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
String >> format2: collection [ 
	"Use double-markers. A single curly bracket used in Pharo documentation can confound #format: 
	Format the receiver by interpolating elements from collection, as in the following examples:  
	'Today is {{1}}.' format: {{Date today}}.
	'Today is {{date}}.' format: (Dictionary with: #date->Date today). 
	'In {{1}} you can escape \{{ by prefixing it with \\' format: {{'strings'}}.  "
	
	^ self class new: self size streamContents: [ :result | | stream |
		stream := self readStream.
		[ stream atEnd ] whileFalse: [ | currentChar | 
			((currentChar := stream next) == ${ and: [ stream peek == ${ ])
				ifTrue: [ | expression index |
					stream next. "gobble peeked element" 
					expression := stream upTo: $}.
					(currentChar := stream next) == $} ifFalse: [ self error: 'Unmatched {{ ' ].
					index := Integer readFrom: expression ifFail: [ expression ].
					result nextPutAll: (collection at: index) asString ]
				ifFalse: [
					currentChar == $\
						ifTrue: [ stream atEnd ifFalse: [ result nextPut: stream next ] ]
						ifFalse: [ result nextPut: currentChar ] ] ] ]
]

{ #category : #'*ExercismTools' }
String >> kebabAsCamelCase [
	"Answer a String that converts the CamelCase input to camel-case kebab output 
	used by exercism"

	^ (self copyReplaceAll: {$-} with: {Character space}) asCamelCase.
]
