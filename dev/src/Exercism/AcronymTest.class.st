"
# Acronym

Convert a phrase to its acronym.

Techies love their TLA (Three Letter Acronyms)!

Help generate some jargon by writing a program that converts a long name
like Portable Network Graphics to its acronym (PNG).

## Hint

Try to find a way to split up a String and then iterate over the resulting sections to output a result. 

"
Class {
	#name : #AcronymTest,
	#superclass : #ExercismTest,
	#instVars : [
		'acronymGenerator'
	],
	#category : #'Exercism-Acronym'
}

{ #category : #meta }
AcronymTest class >> difficulty [
	^2
]

{ #category : #meta }
AcronymTest class >> topics [
	"Answer a String Array of topics that classify the exercise"
	
	^#('strings' 'iteration' 'parsing' 'text-formatting')
]

{ #category : #config }
AcronymTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^ReverseStringTest 
]

{ #category : #meta }
AcronymTest class >> uuid [
	"Answer a unique id for this exercise"
	^'dc7b1fff-f0be-460d-b146-ee84c2acc10b'
]

{ #category : #config }
AcronymTest class >> version [
	"Answer the exercise version number string this test was derived from"
	
	^'1.7.0'
]

{ #category : #setup }
AcronymTest >> setUp [
	acronymGenerator := Acronym new
]

{ #category : #testing }
AcronymTest >> testAllCapsWord [
	self
		assert: (acronymGenerator abbreviate: 'GNU Image Manipulation Program')
		equals: 'GIMP'
]

{ #category : #testing }
AcronymTest >> testBasicAcronym [
	self 
		assert: (acronymGenerator abbreviate: 'Portable Network Graphics') 
		equals: 'PNG'
]

{ #category : #testing }
AcronymTest >> testLowercaseWord [
	self 
		assert: (acronymGenerator abbreviate: 'Ruby on Rails') 
		equals: 'ROR'
]

{ #category : #testing }
AcronymTest >> testPunctuation [
	self 
		assert: (acronymGenerator abbreviate: 'First In, First Out') 
		equals: 'FIFO'
]

{ #category : #testing }
AcronymTest >> testPunctuationWithoutWhitespace [
	self
		assert: (acronymGenerator abbreviate: 'Complementary metal-oxide semiconductor')
		equals: 'CMOS'
]

{ #category : #testing }
AcronymTest >> testVeryLongAbbreviation [
	self
		assert: (acronymGenerator abbreviate: 'Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me')
		equals: 'ROTFLSHTMDCOALM'
]
