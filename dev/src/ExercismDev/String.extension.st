Extension { #name : #String }

{ #category : #'*ExercismDev' }
String >> asValidKeywordName [

	| validName |
	
	validName := self select: [ :c | c isAlphaNumeric or: [ c == $_ ] ].
	
	^validName first isDigit 
		ifTrue: [ 'and' , validName ]
		ifFalse: [ validName ]
]
