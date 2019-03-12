Extension { #name : #String }

{ #category : #'*ExercismDev' }
String >> ->> aCollectionOfAssociations [
	"Similar to -> but converts aCollection to anOrderedDictionary, useful when building JSON structures"

	^self -> aCollectionOfAssociations asOrderedDictionary 
]

{ #category : #'*ExercismDev' }
String >> asValidKeyword [
	"Answer the receiver as a Symbol, which is a valid method keyword or unary message name"

	| validName |
	
	validName := self select: [ :c | c isAlphaNumeric or: [ c == $_ ] ].
	
	^(validName first isDigit 
		ifTrue: [ 'and' , validName ]
		ifFalse: [ validName ]) asSymbol
]
