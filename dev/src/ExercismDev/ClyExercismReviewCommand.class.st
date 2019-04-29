Class {
	#name : #ClyExercismReviewCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #activation }
ClyExercismReviewCommand class >> contextMenuOrder [
		^10
]

{ #category : #testing }
ClyExercismReviewCommand class >> isAbstract [
	
	^self == ClyExercismReviewCommand
]

{ #category : #testing }
ClyExercismReviewCommand class >> isExercismTagIn: aToolContext [

	^ aToolContext selectedClassItems
		detect: [ :any | any actualObject isKindOf: RGObject ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #accessing }
ClyExercismReviewCommand >> defaultMenuIconName [
	^#recentMessages
]

{ #category : #accessing }
ClyExercismReviewCommand >> defaultMenuItemName [
	^'Add Review...'
]

{ #category : #accessing }
ClyExercismReviewCommand >> description [ 
	^'Enter a review comment for the selected item'
]

{ #category : #execution }
ClyExercismReviewCommand >> execute [
	| text element result |
	
	element := self selectedItem.
	text := element propertyNamed: #exercism ifAbsentPut: ''.
	result := UIManager default
		edit: text
		label: ('Review {1}' format: {self selectedItem name})
		accept: [ :newText | element propertyNamed: #exercism put: newText ]
]

{ #category : #accessing }
ClyExercismReviewCommand >> selectedItemIn: aToolContext [
	^self subclassResponsibility 
]
