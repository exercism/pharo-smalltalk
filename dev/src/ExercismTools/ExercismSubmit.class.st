"
# Description
I am a command for submitting an exercise back to Exercism.io.

# Instance Variables
* `exercise` - a string of the exercise to be submitted.
* `exerciseMap` - a dictionary containing the source code of each exercise class in Tonel format. The keys are symbols of the class names.

# Usage
The command can be created an used instantly with `ExercismSubmit exercise: exerciseId`, where `exercisedId` is the string of an exercise name in
kebab case e.g. `'hello-world'`.

The command makes use of the `httpClient` instance variable from the `ExercismCommand` superclass.
"
Class {
	#name : #ExercismSubmit,
	#superclass : #ExercismCommand,
	#instVars : [
		'classes',
		'exerciseMap',
		'packageTag'
	],
	#category : #'ExercismTools-Core'
}

{ #category : #command }
ExercismSubmit class >> class: aClass [ 
	^ self classes: { aClass }
]

{ #category : #command }
ExercismSubmit class >> classes: classes [
	^ (self new classes: classes) execute
]

{ #category : #command }
ExercismSubmit class >> exercise: exerciseId [
	"Submit whole package-tag specified by exerciseId."
	"By default, don't submit TestCases with solution (if needed use #classes: direct)"
	|rootPackage packageTag solutionClasses|
	rootPackage := RPackageOrganizer default packageNamed: 'Exercism'.
	packageTag := rootPackage classTagNamed: exerciseId kebabAsCamelCase.
	solutionClasses := packageTag classes select: [:class | (class new isKindOf: TestCase) not].
	(solutionClasses size > 0) ifFalse: [  self error: 'No classes to submit' ].
	^ self classes: solutionClasses
]

{ #category : #internal }
ExercismSubmit >> buildRequest [
	| multiPartFormDataEntity solutionId |
	multiPartFormDataEntity := ZnMultiPartFormDataEntity new.
	classes do: [ :solutionClass | |solutionPart solutionEntity|
		solutionEntity := ZnByteArrayEntity bytes: (exerciseMap at: solutionClass name asSymbol).
		solutionPart := ZnMimePart exercismFieldName: 'files[]' fileName: solutionClass name, '.st' entity: solutionEntity.
		multiPartFormDataEntity addPart: solutionPart.
	].
	
	solutionId := (ExercismManager solutionData at: packageTag name asKebabCase) at: 'id'.
	
	httpclient 
		url: ApiPath , '/' , solutionId;
		entity: multiPartFormDataEntity
]

{ #category : #accessing }
ExercismSubmit >> classes: arrayOfClasses [
	"Simplification - only submit classes for one exercise at a time"
	| firstPackage rootPkg|
	rootPkg := RPackageOrganizer default packageNamed: 'Exercism'.
	firstPackage := nil.
	arrayOfClasses do: [ :c | |package|
		c isClass ifFalse: [ self error: c printString, ' is not a class.' ].
		package := rootPkg classTagForClass: c.
		firstPackage
			ifNil: [ firstPackage := package ]
			ifNotNil: [ (firstPackage = package) 
				ifFalse: [ self error: 'Classes must belong to same package' ] 
				]
		].
	classes := arrayOfClasses.

]

{ #category : #execution }
ExercismSubmit >> execute [
	|status|
	self writeExercise.
	self buildRequest.
	httpclient patch.
	status := httpclient response statusLine.
	status code = 201 ifTrue: [ self inform: 'Exercism submit solution - SUCCESS.'. ^self ].
	status code = 400 ifTrue: [ self inform: 'Exercism submit solution - NO CHANGES.'. ^self ].
	self error: 'Exercism submit solution - UNKNOWN ERROR (', status code printString, ' ', status reason, ')'.
	
]

{ #category : #execution }
ExercismSubmit >> isOkay [
	|status|
	status := httpclient response statusLine.
	^ (status code = 201) | (status code = 400)
]

{ #category : #internal }
ExercismSubmit >> writeExercise [
	packageTag := (RPackageOrganizer default packageNamed: 'Exercism') classTagForClass: classes anyOne.
	exerciseMap := TonelWriter new mappedSnapshot: packageTag snapshot
]
