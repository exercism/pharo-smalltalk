"
STUB CLASS TODO

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ExercismSubmit,
	#superclass : #ExercismCommand,
	#category : #ExercismTools
}

{ #category : #accessing }
ExercismSubmit class >> solutionDataForClass: aClass [ 
	| exercismPackage classTag |
	exercismPackage := RPackageOrganizer default 
		packageNamed: 'Exercism' 
		ifAbsent: [ self error: 'No exercises downloaded.' ].
	classTag := exercismPackage classTagForClass: aClass.  
	^ exercismPackage ensureProperties at: classTag.
	
]

{ #category : #accessing }
ExercismSubmit class >> solutionDataForExercise: exerciseString [ 
	| exercismPackage |
	exercismPackage := RPackageOrganizer default 
		packageNamed: 'Exercism' 
		ifAbsent: [ self error: 'No exercises downloaded.' ].
	exercismPackage ensureProperties 
		detect: [ :solutionData | ((solutionData at: 'exercise') at: 'id') = exerciseString ] 
		ifFound: [ :solutionData | ^ solutionData ] 
		ifNone: [ self error: 'Exercise ''' , exerciseString , ''' not downloaded.'].
	
]
