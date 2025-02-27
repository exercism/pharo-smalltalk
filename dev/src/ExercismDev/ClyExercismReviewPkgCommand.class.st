Class {
	#name : 'ClyExercismReviewPkgCommand',
	#superclass : 'ClyExercismReviewCommand',
	#category : 'ExercismDev-Menus',
	#package : 'ExercismDev',
	#tag : 'Menus'
}

{ #category : 'activation' }
ClyExercismReviewPkgCommand class >> cmdShortcutActivation [
	<classAnnotation>
	
	^CmdShortcutActivation by: $e meta, $r meta for: ClyClassContextOfFullBrowser 
]

{ #category : 'activation' }
ClyExercismReviewPkgCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation
		byItemOf: ClyExercismMenuGroup
		order: self contextMenuOrder
		for: RPackage asCalypsoItemContext
]

{ #category : 'accessing' }
ClyExercismReviewPkgCommand >> selectedItemIn: aToolContext [
	^ aToolContext lastSelectedClassGroup
]
