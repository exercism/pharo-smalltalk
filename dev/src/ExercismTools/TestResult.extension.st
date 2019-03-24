Extension { #name : #TestResult }

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
		nextPutAll:' errors ' ]
]
