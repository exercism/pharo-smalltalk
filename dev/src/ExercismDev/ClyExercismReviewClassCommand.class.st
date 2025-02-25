Class {
	#name : 'ClyExercismReviewClassCommand',
	#superclass : 'ClyExercismReviewCommand',
	#category : 'ExercismDev-Menus',
	#package : 'ExercismDev',
	#tag : 'Menus'
}

{ #category : 'activation' }
ClyExercismReviewClassCommand class >> cmdShortcutActivation [
	<classAnnotation>
	
	^CmdShortcutActivation by: $e meta, $r meta for: ClyClassContextOfFullBrowser 
]

{ #category : 'activation' }
ClyExercismReviewClassCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: ClyClass asCalypsoItemContext 
]

{ #category : 'accessing' }
ClyExercismReviewClassCommand >> selectedItemIn: aToolContext [
	^ aToolContext selectedClassItems first actualObject  
]
