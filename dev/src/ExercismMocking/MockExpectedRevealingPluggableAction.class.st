Class {
	#name : #MockExpectedRevealingPluggableAction,
	#superclass : #MockExpectedPluggableAction,
	#instVars : [
		'count'
	],
	#category : #ExercismMocking
}

{ #category : #evaluating }
MockExpectedRevealingPluggableAction >> executeFor: anOccurredMessage [
	"Insert a hook to give a better failure for an expectation, that shows the offending method as well as the spec failure. This change also provides an optional final count parameter, which an expection can use to compare sequential calls or customize return results"
	
	count := count + 1.
	
	^ [ block valueWithEnoughArguments: (anOccurredMessage arguments copyWith: count) ]
		on: SpecOfFailed
		do: [ :ex | 
			ex
				resignalAs:
					(MockExpectationFailure new
						messageText:
							'Expectation failure: ', anOccurredMessage receiver mockName, '>>#' , anOccurredMessage selector , ' ('
								, ex messageText uncapitalized, ')';
						yourself) ]
]

{ #category : #evaluating }
MockExpectedRevealingPluggableAction >> initialize [
	super initialize.
	count := 0.
]
