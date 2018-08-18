"
While there is a #reversed method for Strings, can you figure out how to do this yourself with lower level character iteration or streams? 

To help you browse code, Pharo has a neat code finder tool. Press Shift-Enter to activate it.

NOTE: We have followed the Exercism convention of calling the solution ReverseString, however a more Smalltalk name would be StringReverser.


"
Class {
	#name : #ReverseStringTest,
	#superclass : #TestCase,
	#instVars : [
		'stringReverser'
	],
	#category : #'Exercism-ReverseString'
}

{ #category : #setup }
ReverseStringTest >> setUp [
	stringReverser := ReverseString new
]

{ #category : #testing }
ReverseStringTest >> testCapitalisedWorld [
	self 
		assert: (stringReverser reverse: 'Ramen') 
		equals: 'nemaR'
]

{ #category : #testing }
ReverseStringTest >> testEmptyString [
	self 
		assert: (stringReverser reverse: '') 
		equals: ''
]

{ #category : #testing }
ReverseStringTest >> testSentenceWithPunctuation [
	self 
		assert: (stringReverser reverse: 'I''m hungry!') 
		equals: '!yrgnuh m''I'
]

{ #category : #testing }
ReverseStringTest >> testSingleWorld [
	self
		assert: (stringReverser reverse: 'robot')
		equals: 'tobor'
]

{ #category : #testing }
ReverseStringTest >> testWithPalindrome [
	self
		assert: (stringReverser reverse: 'racecar')
		equals: 'racecar'

]
