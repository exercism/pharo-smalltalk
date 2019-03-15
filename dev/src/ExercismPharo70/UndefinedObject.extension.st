Extension { #name : #UndefinedObject }

{ #category : #'*ExercismPharo70' }
UndefinedObject >> doesNotUnderstand: aMessage [
	<debuggerCompleteToSender>
	"Handle the fact that there was an attempt to send the given message to an Undeclared variable (nil), hence the receiver does not understand this message (typically #new)."
	"Testing: (3 activeProcess)"

	| exception resumeValue node |
	
	(node := self findUndeclaredVariableIn: thisContext sender sourceNodeExecuted) ifNil: [ 
		 ^super doesNotUnderstand: aMessage ].
				
	(exception := ClassNotUnderstood new)
			message: aMessage;
			variableNode: node;
			receiver: self.
			
	resumeValue := exception signal.
	^ exception reachedDefaultHandler
			ifTrue: [ aMessage sentTo: self ]
			ifFalse: [ resumeValue ] .
			
	
]

{ #category : #'*ExercismPharo70' }
UndefinedObject >> findUndeclaredVariableIn: ast [

	ast nodesDo: [:n |
	(n isVariable and: [ n isUndeclared]) ifTrue: [ ^n ]].

	^nil
]
