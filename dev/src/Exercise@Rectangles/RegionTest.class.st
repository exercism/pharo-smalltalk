"
A RegionTest is a test class for testing the behavior of Region
"
Class {
	#name : 'RegionTest',
	#superclass : 'TestCase',
	#category : 'Exercise@Rectangles',
	#package : 'Exercise@Rectangles'
}

{ #category : 'tests' }
RegionTest >> testHeigth [
	self assert: (Region topLeft: 1@3 bottomRight: 3@4) height equals: 1
]

{ #category : 'tests' }
RegionTest >> testIsValid [
	self deny: (Region topLeft: 5@3 bottomRight: 3@4) isValid.
	self deny: (Region topLeft: 5@3 bottomRight: 5@2) isValid.
	self deny: (Region topLeft: 5@3 bottomRight: 5@3) isValid.
]

{ #category : 'tests' }
RegionTest >> testSides [
	| sides |
	sides := (2@2 region: 5@4) sides.
	self assert: sides first start equals: 2@2.
	self assert: sides first end equals: 5@2.
	
	self assert: sides second start equals: 2@4.
	self assert: sides second end equals: 5@4.
	
	self assert: sides third start equals: 2@2.
	self assert: sides third end equals: 2@4.
	
	self assert: sides last start equals: 5@2.
	self assert: sides last end equals: 5@4.
]

{ #category : 'tests' }
RegionTest >> testWidth [
	self assert: (Region topLeft: 1@2 bottomRight: 3@4) width equals: 2
]
