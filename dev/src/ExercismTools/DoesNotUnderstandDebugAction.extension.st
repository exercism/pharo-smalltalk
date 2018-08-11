Extension { #name : #DoesNotUnderstandDebugAction }

{ #category : #'*ExercismTools' }
DoesNotUnderstandDebugAction >> closeWindow [
	"Safely close the debugger window without destroying the debugger context and stack"
	| modelWindow |
	modelWindow := self debugger window.
	modelWindow
		model: nil;
		close
]

{ #category : #'*ExercismTools' }
DoesNotUnderstandDebugAction >> createMissingClassIn: aContext [
	| senderContext newClassVar variableNode previousContext errorMsgNode |
	
	variableNode := nil.
	
	[ senderContext := aContext sender.
	errorMsgNode := senderContext method sourceNodeExecutedForPC: senderContext pc.
	variableNode := self findUndeclaredVariableIn: errorMsgNode ]
		on: Error
		do: [ self error: 'Unable to create missing class' ].
		
	newClassVar := OCUndeclaredVariableWarning new
		node: variableNode;
		defineClass: variableNode name.
		
	previousContext := aContext stack second.
	
	self closeWindow.
	
	previousContext restart
]

{ #category : #'*ExercismTools' }
DoesNotUnderstandDebugAction >> executeAction [
	"Should only be called when the debugger was created in response to a
	MessageNotUnderstood exception. Create a stub for the method that was
	missing and proceed into it.
	
	Modified to allow createMissingClass hook - #tm"
	
	| msg msgCategory chosenClass |
	
	msg := self interruptedContext tempAt: 1.
	(msg lookupClass == UndefinedObject ) ifTrue: [ 
		^self createMissingClassIn: self interruptedContext ].
	
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

{ #category : #'*ExercismTools' }
DoesNotUnderstandDebugAction >> findUndeclaredVariableIn: errorMsgNode [
	^ errorMsgNode allChildren
		detect: [ :n | n isVariable and: [ n isUndeclared ] ]
		ifNone: [ errorMsgNode parent allChildren
				detect: [ :n | n isVariable and: [ n isUndeclared ] ] ]
]
