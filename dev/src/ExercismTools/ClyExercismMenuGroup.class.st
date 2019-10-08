"
# ClyExercismMenuGroup

I am the group of Exercism menu item commands. My class can be used to
group Exercism specific menu items.

I am used in `ClyExercismExerciseCommand class>>#packageContextMenuActivation`
and `ClyExercismExerciseCommand class >>#tagContextMenuActivation`.

 
"
Class {
	#name : #ClyExercismMenuGroup,
	#superclass : #CmdMenuGroup,
	#category : #'ExercismTools-Menus'
}

{ #category : #accessing }
ClyExercismMenuGroup >> name [
	^'Exercism'
]

{ #category : #accessing }
ClyExercismMenuGroup >> order [
	^1
]
