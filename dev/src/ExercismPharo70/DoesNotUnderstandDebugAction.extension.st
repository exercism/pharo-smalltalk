Extension { #name : #DoesNotUnderstandDebugAction }

{ #category : #'*ExercismPharo70' }
DoesNotUnderstandDebugAction >> createMissingClassWith: variableNode in: aContext [
	|  previousContext  |
		
	OCUndeclaredVariableWarning new
		node: variableNode;
		defineClass: variableNode name.
		
	previousContext := aContext stack second.
	
	self closeWindow.
	
	previousContext restart
]

{ #category : #'*ExercismPharo70' }
DoesNotUnderstandDebugAction >> executeAction [
	"Should only be called when the debugger was created in response to a
	MessageNotUnderstood exception. Create a stub for the method that was
	missing and proceed into it, or create a class if it was missing instead"
	
	| msg msgCategory chosenClass exception |
	
	msg := self interruptedContext tempAt: 1.
	exception := self interruptedContext tempAt: 2.
	
	(exception class == ClassNotUnderstood) ifTrue: [ 
		self createMissingClassWith: exception variableNode in: self interruptedContext ].
	
	chosenClass := self 
		askForSuperclassOf: self interruptedContext receiver class
		toImplement: msg selector
		ifCancel: [^self].
	msgCategory := (self askForCategoryIn: chosenClass default: 'as yet unclassified').
	self  session
		implement: msg 
		classified: msgCategory 
		inClass: chosenClass 
		forContext: self interruptedContext.
	self debugger selectTopContext
]
