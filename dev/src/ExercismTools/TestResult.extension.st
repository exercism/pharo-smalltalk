Extension { #name : #TestResult }

{ #category : #'*ExercismTools' }
TestResult >> exercismEnvironmentInfoOn: aStream [

	aStream 
	 	nextPutAll: 'Used OS/Platform: ';
		nextPutAll: Smalltalk os platformName; space;
		nextPutAll: Smalltalk os version; space;
		nextPutAll: Smalltalk os subtype;
		crlf;
		nextPutAll: 'Image version: ';
		nextPutAll: SystemVersion current version; space;
		nextPutAll: 'build: ';
		nextPutAll: SystemVersion current build asString;
		nextPutAll: (Smalltalk vm is32bit 
			ifTrue: [ ' (32 Bit)' ]
			ifFalse: [ ' (64 Bit)' ]).
	aStream 
		crlf;
		nextPutAll: 'VM version: ';
		nextPutAll: Smalltalk vm interpreterSourceVersion
		 
]

{ #category : #'*ExercismTools' }
TestResult >> exercismSummary [
	^String streamContents: [ :s | s 
		nextPutAll: 'Tested on: ';
		nextPutAll: self timeStamp asLocalStringYMDHM;
		crlf;
		nextPutAll: self runCount printString;
		nextPutAll: ' run, ';
		nextPutAll: self expectedPassCount printString;
		nextPutAll: ' passes, ';
		nextPutAll: self skippedCount printString;
		nextPutAll: ' skipped, ';
		nextPutAll: self unexpectedFailureCount printString;
		nextPutAll: ' failures, ';
		nextPutAll: self unexpectedErrorCount printString;
		nextPutAll:' errors.';
		crlf.
		self exercismEnvironmentInfoOn: s.
	]
]
