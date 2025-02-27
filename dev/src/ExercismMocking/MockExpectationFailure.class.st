Class {
	#name : 'MockExpectationFailure',
	#superclass : 'AssertionFailure',
	#category : 'ExercismMocking',
	#package : 'ExercismMocking'
}

{ #category : 'exceptiondescription' }
MockExpectationFailure >> defaultAction [
	| triggerContext |
	
	"Try and find a better context for where this happened"
	"triggerContext := self signalerContext findContextSuchThat:
		[ :context | context method selector = #doesNotUnderstand: ].
	"
	
	"Trigger the debugger where the failure happened"
	Processor activeProcess
		debug: (triggerContext ifNil: [ self signalerContext ])
		title: self messageText
		
]
