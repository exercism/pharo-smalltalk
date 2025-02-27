"
I indicate if an exercism review element (an RGObject) has a comment
"
Class {
	#name : 'ClyExercismReviewTableDecorator',
	#superclass : 'ClyTableDecorator',
	#category : 'ExercismDev-Review',
	#package : 'ExercismDev',
	#tag : 'Review'
}

{ #category : 'decoration' }
ClyExercismReviewTableDecorator class >> decorateMainTableCell: anItemCellMorph of: aDataSourceItem [

	super decorateMainTableCell: anItemCellMorph of: aDataSourceItem.
	
	(aDataSourceItem actualObject isKindOf: RGObject)
		ifTrue: [ 
			(aDataSourceItem actualObject
				propertyNamed: #exercism
				ifAbsent: [ ^ self ])
					ifNotEmpty: [ anItemCellMorph addExtraIcon: #announcement ] ]
]

{ #category : 'decoration' }
ClyExercismReviewTableDecorator class >> decorateTableCell: anItemCellMorph of: aDataSourceItem [

	
]

{ #category : 'decoration' }
ClyExercismReviewTableDecorator class >> decorationStrategy [
	<classAnnotation>
	
	^ClyTableDecorationStrategy for: ClyFullBrowserContext
]
