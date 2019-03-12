Class {
	#name : #ExercismSubmission,
	#superclass : #Object,
	#instVars : [
		'exercismData',
		'contentData'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #accessing }
ExercismSubmission class >> baseUrlKey [
	^ 'file_download_base_url'
]

{ #category : #accessing }
ExercismSubmission class >> data: exercismDataDictionary [
	^ self new
		exercismData:
			(exercismDataDictionary
				at: 'solution'
				ifAbsent: [ self error: 'Invalid data format' ]);
		yourself
]

{ #category : #accessing }
ExercismSubmission >> baseUrl [ 
	^(self exercismData at: self class baseUrlKey) exPathString.
]

{ #category : #accessing }
ExercismSubmission >> contentData [
	^ contentData
]

{ #category : #accessing }
ExercismSubmission >> contentData: anObject [
	contentData := anObject
]

{ #category : #accessing }
ExercismSubmission >> contentsFor: aString [ 
	^self contentData at: aString
]

{ #category : #accessing }
ExercismSubmission >> exerciseId [
	^(self exercismData at: 'exercise') at: 'id'
]

{ #category : #accessing }
ExercismSubmission >> exercismData [
	^ exercismData
]

{ #category : #accessing }
ExercismSubmission >> exercismData: anObject [
	exercismData := anObject
]

{ #category : #accessing }
ExercismSubmission >> filenames [
	^self exercismData at: 'files'
]

{ #category : #accessing }
ExercismSubmission >> initialize [ 

	super initialize.
	self contentData: Dictionary new.
]

{ #category : #retrieving }
ExercismSubmission >> populateFileContentWith: aBlockClosure [ 
	
	| baseUrl |
	baseUrl := self baseUrl.
	
	self sourceFilenames do: [ :filename |
		self contentData at: filename put: (aBlockClosure value: baseUrl, filename) ]
]

{ #category : #accessing }
ExercismSubmission >> sourceFilenames [
	
	^self filenames select: [:filename | filename endsWith: '.st' ]
]

{ #category : #retrieving }
ExercismSubmission >> sourceFilesDo: aBlockClosure [ 
	
	self sourceFilenames do: [ :filename |
		| source |

		source := self contentsFor: filename.
		aBlockClosure value: filename value: source ]
]

{ #category : #accessing }
ExercismSubmission >> submissionId [
	^self exercismData at: 'id'
]
