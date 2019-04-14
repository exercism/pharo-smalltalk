Class {
	#name : #ClyExercismReviewSummaryCommand,
	#superclass : #ClyExercismCommand,
	#category : #'ExercismDev-Menus'
}

{ #category : #activation }
ClyExercismReviewSummaryCommand class >> cmdShortcutActivation [
	<classAnnotation>
	
	^CmdShortcutActivation by: $w meta, $s meta for: ClyClassContextOfFullBrowser 
]

{ #category : #activation }
ClyExercismReviewSummaryCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: RPackage asCalypsoItemContext
]

{ #category : #activation }
ClyExercismReviewSummaryCommand class >> contextMenuOrder [
		^5
]

{ #category : #activation }
ClyExercismReviewSummaryCommand class >> rcmdShortcutActivation [
	<classAnnotation>
	
	^CmdShortcutActivation by: $e meta, $s meta for: ClyClassContextOfFullBrowser 
]

{ #category : #accessing }
ClyExercismReviewSummaryCommand >> defaultMenuIconName [
	^#book
]

{ #category : #accessing }
ClyExercismReviewSummaryCommand >> defaultMenuItemName [
	^'View Review Summary...'
]

{ #category : #accessing }
ClyExercismReviewSummaryCommand >> description [ 
	^'Output a review summary that can be pasted into Exercism'
]

{ #category : #accessing }
ClyExercismReviewSummaryCommand >> execute [
	| element result |

	element := self packages first.
	result := String streamContents: [:s | 
		element summaryOn: s.
		element classes do: [ :item | 
			item metaclass summaryOn: s.
			item metaclass methods do: [ :m | m summaryOn: s ].
			item summaryOn: s.
			item methods do: [ :m | m summaryOn: s ] ]].
	result inspect
]

{ #category : #accessing }
ClyExercismReviewSummaryCommand >> selectedItemIn: aToolContext [
	^ aToolContext selectedClassItems first actualObject  
]
