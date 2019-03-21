"
I am the command for dowloading an exercise and installing it in the image
"
Class {
	#name : #ExercismDownloadCommand,
	#superclass : #ExercismFetchCommand,
	#instVars : [
		'exerciseId',
		'trackName'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #command }
ExercismDownloadCommand class >> from: aClient track: trackId exercise: exerciseId [
	^self new 
		httpClient: aClient;
		track: trackId exercise: exerciseId;
		yourself
]

{ #category : #command }
ExercismDownloadCommand class >> track: trackId exercise: exerciseId [
	^ self from: ExercismHttpClient new track: trackId exercise: exerciseId
]

{ #category : #execution }
ExercismDownloadCommand >> execute [
	^ self
		executeCheckingToken: [ | submission |

			submission := self fetchLatestSubmission.

			self fetchExerciseFilesFor: submission.
			self installExerciseFor: submission.
			submission storeSolutionId.

			submission ]
]

{ #category : #internal }
ExercismDownloadCommand >> installExerciseFor: submission [

	submission
		sourceFilenamesWithContentsDo:
			[ :filename :contents | (self parser documentFrom: contents) do: [ :def | def load ] ].
		
	SystemAnnouncer uniqueInstance
		announce: (RPackageRegistered to: ExercismManager exercismPackage).
	
]

{ #category : #internal }
ExercismDownloadCommand >> retrieveLatestData [
	| responseString |
		
	responseString := self httpClient getLatestExercise: exerciseId for: trackName.
	^ STON fromString: responseString
]

{ #category : #accessing }
ExercismDownloadCommand >> track: aStringTrackName exercise: aStringExerciseId [
	trackName := aStringTrackName.
	exerciseId := aStringExerciseId asKebabCase.
]
