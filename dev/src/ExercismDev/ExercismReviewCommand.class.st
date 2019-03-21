"
A command for retrieving infomation for a review
"
Class {
	#name : #ExercismReviewCommand,
	#superclass : #ExercismFetchCommand,
	#instVars : [
		'reviewId'
	],
	#category : #'ExercismDev-Core'
}

{ #category : #command }
ExercismReviewCommand class >> from: aClient reviewId: reviewId [
	^self new 
		httpClient: aClient;
		reviewId: reviewId;
		yourself
]

{ #category : #command }
ExercismReviewCommand class >> reviewId: reviewId [
	^self from: ExercismHttpClient new reviewId: reviewId
]

{ #category : #internal }
ExercismReviewCommand >> createSnapshotFor: submission [
	| snapshot |
	
	snapshot := OrderedCollection new.
	submission
		sourceFilenamesWithContentsDo:
			[ :filename :contents | snapshot addAll: (self parser documentFrom: contents) ].
		
	^MCSnapshot fromDefinitions: snapshot 
	
]

{ #category : #execution }
ExercismReviewCommand >> execute [
	
	^self executeCheckingToken: [ | submission snapshot |

		submission := self fetchLatestSubmission.

		self fetchExerciseFilesFor: submission.
		snapshot := self createSnapshotFor: submission.
	
		ExercismReview for: submission with: snapshot.
	]
]

{ #category : #internal }
ExercismReviewCommand >> retrieveLatestData [
	| responseString |
		
	responseString := self httpClient getSpecifiedExercise: self reviewId.
	^ STON fromString: responseString
]

{ #category : #accessing }
ExercismReviewCommand >> reviewId [
	^ reviewId
]

{ #category : #accessing }
ExercismReviewCommand >> reviewId: anObject [
	reviewId := anObject
]
