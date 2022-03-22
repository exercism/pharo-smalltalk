Extension { #name : #StDebugger }

{ #category : #'*ExercismPharo90' }
StDebugger >> createMissingClass [

	| variableNode |
	variableNode := self session exception variableNode.
	[ 
	| newClassBinding |
	self flag: 'This method is actually hard to test because it requires user input to complete. How to test that automatically?'.
	newClassBinding := OCUndeclaredVariableWarning new
		                   node: variableNode;
		                   defineClass: variableNode name ]
		on: Abort
		do: [ ^ self ].

	self debuggerActionModel restartContext:
		self interruptedContext sender
]
