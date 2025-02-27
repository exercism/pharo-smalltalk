Extension { #name : 'ExercismTest' }

{ #category : '*ExercismTestRunner' }
ExercismTest >> exercismTestResultInfo [

	|testResultDict|
	testResultDict := OrderedDictionary new.
	testResultDict 
		add: 'name' -> self humanReadableName;
		add: 'status' -> self statusString.
	self resultMessage ifNotEmpty: 
	[	:aString | 	
		testResultDict add:  'message' -> aString
	].
	testResultDict add: 'test_code' -> self sourceCodeString.
	^ testResultDict 
]

{ #category : '*ExercismTestRunner' }
ExercismTest >> humanReadableName [

	| readName |
	readName := (self selector includes: $_)
		            ifTrue: [ self selector copyAfterLast: $_ ]
		            ifFalse: [ self selector withoutPrefix: 'test' ].
	^ readName asSentenceCase trim capitalized
]

{ #category : '*ExercismTestRunner' }
ExercismTest >> resultDebugInfo [

	| writeStream |
	writeStream := WriteStream on: ''.
	[ self runCase ]
		on: Error , TestFailure , TestTookTooMuchTime
		do: [ :anException | 
			| aContext |
			aContext := anException signalerContext.
			[ 
			aContext isNil or: [ 
				aContext receiver == self and: [ 
					aContext selector == #runCase ] ] ] whileFalse: [ 
				[ 
				writeStream
					nextPutAll: aContext printString;
					lf 
				] 
				on: Error do: [ 
					writeStream
						nextPutAll:
							('Error during printing of stacktrace: {1}>>{2}.' format: { 
										 self class name.
										 self selector });
						lf ].
				aContext := aContext sender ]].
		^ writeStream contents withUnixLineEndings
]

{ #category : '*ExercismTestRunner' }
ExercismTest >> resultMessage [
	|errMessageStream|
	errMessageStream := WriteStream on: ''.
	[self runCase] on: 
			Error, 
			TestFailure, 
			TestTookTooMuchTime  
		do: [:ex |
			errMessageStream nextPutAll: ex messageText.
			errMessageStream lf.
			errMessageStream nextPutAll: '---Stack-trace---'.
			errMessageStream lf.
			errMessageStream nextPutAll: self resultDebugInfo
		].
	^ errMessageStream contents
]

{ #category : '*ExercismTestRunner' }
ExercismTest >> sourceCodeString [
	"using LF lineending since it will be bumped to json format"
	^ (self class compiledMethodAt: self selector) sourceCode withUnixLineEndings
]

{ #category : '*ExercismTestRunner' }
ExercismTest >> statusString [ 

	(self class methodPassed: self selector) ifTrue: [^ 'pass'].
	(self class methodFailed: self selector) ifTrue: [^ 'fail'].
	(self class methodRaisedError: self selector) ifTrue: [^ 'error'].
]
