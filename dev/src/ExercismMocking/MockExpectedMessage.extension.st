Extension { #name : #MockExpectedMessage }

{ #category : #'*ExercismMocking' }
MockExpectedMessage >> atLeastOnce [
	"Mark the expectation as: should be used at least once. Useful when using #expecting"
	
	spec usage minCount: 1
]

{ #category : #'*ExercismMocking' }
MockExpectedMessage >> specifying: aBlock [
	"Provide a hook for easily specifying state-spec expectations on a mock e.g.:
		(myMock expect someMessage: Arg) specifying: [ :param :count | 
				param should equal: 'p1'. 'result', count asString ].
			
	Note in the above, :count is optional "
			
	actions add: (MockExpectedRevealingPluggableAction basedOn: aBlock).
	spec usage minCount: 1
]

{ #category : #'*ExercismMocking' }
MockExpectedMessage >> used: numberOfTimes [
	"An alias for use:, but grammatical nices when used with #expecting:"
	
	self use: numberOfTimes 
]
