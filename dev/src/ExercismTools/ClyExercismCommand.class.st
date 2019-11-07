"
# ClyExercismCommand

I provide menu facilities for Exercism that should only appear in the 
context of an Exercism package (and not in other browser packages).

I am an abstract class.

## Design

I follow the Command Pattern of Object Oriented Design. I do one task 
on recieving the `#execute` message, which must be implemented by 
subclasses. All other methods should be about setting up the state
requred for the `#execute` method to carry out its task.

The `#execute` method is written further up the inheritance hierarchy
at `CmdCommand>>#execute`.

## Instance Variables

- browser: ClyPackageContextOfFullBrowser, the context of of a browser instance containing packages.
- selectedItem: RPackage, the selected package in the browser context.
"
Class {
	#name : #ClyExercismCommand,
	#superclass : #SycPackageCommand,
	#instVars : [
		'browser',
		'selectedItem'
	],
	#category : #'ExercismTools-Menus'
}

{ #category : #activation }
ClyExercismCommand class >> canBeExecutedInContext: aToolContext [
	^ (super canBeExecutedInContext: aToolContext)
		and: [ self isExercismTagIn: aToolContext ]
]

{ #category : #testing }
ClyExercismCommand class >> isAbstract [
	
	^self == ClyExercismCommand
]

{ #category : #testing }
ClyExercismCommand class >> isExercismTagIn: aToolContext [
	
	^false
]

{ #category : #accessing }
ClyExercismCommand >> browser [
	^ browser
]

{ #category : #accessing }
ClyExercismCommand >> browser: anObject [
	browser := anObject
]

{ #category : #execution }
ClyExercismCommand >> prepareFullExecutionInContext: aToolContext [
	super prepareFullExecutionInContext: aToolContext.

	self selectedItem: (self selectedItemIn: aToolContext).
	self browser: aToolContext tool
]

{ #category : #accessing }
ClyExercismCommand >> selectedItem [
	^ selectedItem
]

{ #category : #accessing }
ClyExercismCommand >> selectedItem: anObject [
	selectedItem := anObject
]

{ #category : #accessing }
ClyExercismCommand >> selectedItemIn: aToolContext [
	^ aToolContext lastSelectedClassGroup
]
