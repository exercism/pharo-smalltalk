Class {
	#name : #ExercismTest,
	#superclass : #TestCase,
	#category : #'ExercismTools-Core'
}

{ #category : #config }
ExercismTest class >> autoApprove [
	"Answer a Boolean, true if this exercise is auto-approved when submitted"
	
	^false
]

{ #category : #config }
ExercismTest class >> core [
	"Answer a Boolean, true if this is a core exercise"
	
	^false
]

{ #category : #config }
ExercismTest class >> deprecated [
	"Answer a Boolean, true if this is a deprecated exercise (normally false)"
	
	^false
]

{ #category : #config }
ExercismTest class >> difficulty [
	"Answer an Integer, the difficulty level of the test, 1=easy, 10=hard"
	
	^self subclassResponsibility 
]

{ #category : #helper }
ExercismTest class >> followedBy [
	"Answer the String name of the next core exercise that follows, otherwise nil if nothing comes after.
	
	This data provides a hook for users to load the next core exercise"
	
	^self unlockedBy ifNotNil: [ :parent | parent followedBy ]
]

{ #category : #helper }
ExercismTest class >> hintText [
	"Answer the String, that is the hint text for exerciems (this is the text afer the markdown heading ## Hint"

	| hintIndex |
	self comment
		ifNotNil: [ :comment | 
			| hintMarker |
			hintMarker := '## Hint'.
			hintIndex := comment findString: hintMarker.
			hintIndex > 0
				ifTrue: [ ^ (comment allButFirst: hintIndex + hintMarker size) trimBoth ] ].
	^ ''
]

{ #category : #config }
ExercismTest class >> slug [
	"Answer the kebab name of the exercise"
	
	^(self name asString withoutSuffix: 'Test') asKebabCase 
]

{ #category : #config }
ExercismTest class >> topics [
	"Answer a String Array of topics that classify the exercise.
	Topics are commonly found in (but not limited to): 
		https://github.com/exercism/problem-specifications/blob/master/TOPICS.txt
		
	e.g.
	^#('strings' 'iteration' 'text-formatting')"
	
	^self subclassResponsibility 
]

{ #category : #config }
ExercismTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^self subclassResponsibility  
]

{ #category : #config }
ExercismTest class >> uuid [
	"Answer a fixed String, the unique UUID for this exercise so the Exercism platform can identify it.
	The id should be like: 'b5812b5e-2788-4ea6-b948-bfe54edeb0da' "
	
	^self subclassResponsibility 
]

{ #category : #config }
ExercismTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^self subclassResponsibility  
]

{ #category : #helper }
ExercismTest class >> wordifiedName [
	"Answer the english readable name of the exercise"
	
	^String
		streamContents: [ :aStream |
			(self name asString withoutSuffix: 'Test') 
				doWithIndex: [ :char :i |
					(char isUppercase and: [ i > 1 ])
						ifTrue: [ aStream space ].
					aStream nextPut: char ] ]
]
