Extension { #name : 'String' }

{ #category : '*ExercismDev' }
String >> asValidKeyword [
	"Answer the receiver as a Symbol, which is a valid method keyword or unary message name"

	| validName |
	
	validName :=self.
	
	{  
	'<='->'Less Than Or Equal To'. 
	'>='-> 'Greater Than Or Equal To'.
	'<>'->'Not Equal To'.
	'<'->'Less Than'. 
	'>'->'Greater Than'. 
	'='->'Equals'} do: 
		[ :assoc | validName := validName copyReplaceAll: assoc key with: assoc value  ].
	
	validName := validName select: [ :c | c isAlphaNumeric or: [ c == $_ ] ].
	
	^(validName first isDigit 
		ifTrue: [ (self isAllDigits ifTrue: ['at' ] ifFalse: ['and']) , validName ]
		ifFalse: [ validName ]) asSymbol
]
