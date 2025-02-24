Class {
	#name : 'ClyExercismReviewMethodCommand',
	#superclass : 'ClyExercismReviewCommand',
	#category : 'ExercismDev-Menus',
	#package : 'ExercismDev',
	#tag : 'Menus'
}

{ #category : 'activation' }
ClyExercismReviewMethodCommand class >> cmdShortcutActivation [
	<classAnnotation>
	
	^CmdShortcutActivation by: $e meta, $r meta for: ClyMethodContextOfFullBrowser 
]

{ #category : 'activation' }
ClyExercismReviewMethodCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: ClyMethod asCalypsoItemContext 
]

{ #category : 'accessing' }
ClyExercismReviewMethodCommand >> selectedItemIn: aToolContext [
	^ aToolContext selectedMethodItems first actualObject  
]
