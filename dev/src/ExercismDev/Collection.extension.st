Extension { #name : #Collection }

{ #category : #'*ExercismDev' }
Collection >> asJSON [
	"Answer the receiver as a JSON string for Exercism, useful for tesing"

	^ STONJSONWriter streamContentsOf: self
]
