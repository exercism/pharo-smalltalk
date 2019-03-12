Extension { #name : #MockExpectedMessage }

{ #category : #'*ExercismMocking' }
MockExpectedMessage >> specifying: aBlock [
	"Provide a hook for easily specifying state-spec expectations on a mock e.g.:
		(myMock expect someMessage: Arg) specifying: [ :param :count | 
				param should equal: 'p1'. 'result', count asString ].
			
	Note in the above, :count is optional "
			
	actions add: (MockExpectedRevealingPluggableAction basedOn: aBlock).
	spec usage minCount: 1
]
