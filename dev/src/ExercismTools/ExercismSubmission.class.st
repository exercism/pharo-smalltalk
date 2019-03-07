Class {
	#name : #ExercismSubmission,
	#superclass : #Object,
	#instVars : [
		'exercismData',
		'files'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #accessing }
ExercismSubmission class >> data: exercismDataDictionary [
	^self new
		exercismData: exercismDataDictionary;
		yourself
]

{ #category : #'as yet unclassified' }
ExercismSubmission >> baseURL [
	^self exercismData at: 'file_download_base_url'
]

{ #category : #'as yet unclassified' }
ExercismSubmission >> contentsFor: aString [ 
	^self files at: aString
]

{ #category : #accessing }
ExercismSubmission >> exercismData [
	^ exercismData
]

{ #category : #accessing }
ExercismSubmission >> exercismData: anObject [
	exercismData := anObject
]

{ #category : #'as yet unclassified' }
ExercismSubmission >> filenames [
	^self exercismData at: 'files'
]

{ #category : #accessing }
ExercismSubmission >> files [
	^ files
]

{ #category : #accessing }
ExercismSubmission >> files: anObject [
	files := anObject
]

{ #category : #'as yet unclassified' }
ExercismSubmission >> id [
	^self exercismData at: 'id'
]

{ #category : #'as yet unclassified' }
ExercismSubmission >> includes: aString [ 
	^self filenames includes: aString
]

{ #category : #'as yet unclassified' }
ExercismSubmission >> sourceFilesDo: aBlockClosure [ 
	
	self filenames select: [:filename | filename endsWith: '.st' ] thenDo: [ :filename |
		| source |

		source := self files at: filename.
		aBlockClosure value: filename value: source ]
]
