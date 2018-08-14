"
While text processing can be achieved using methods on String, can you make use of the different
Streams available in Pharo?

"
Class {
	#name : #,
	#superclass : #TestCase,
	#instVars : [
		'acronymGenerator'
	],
	#category : #'Exercism-Acronym'
}

{ #category : #setup }
AcronymTest >> setUp [
	acronymGenerator := Acronym new
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
AcronymTest >> testAllCapsWord [
	self
		assert: (acronymGenerator abbreviate: 'GNU Image Manipulation Program')
		equals: 'GIMP'
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
