Class {
	#name : #SpaceAgeTest,
	#superclass : #TestCase,
	#category : #'Exercism-SpaceAge'
}

{ #category : #asserting }
SpaceAgeTest >> assert: actualNumber closeEnoughTo: expectedNumber [
	self
		assert: (actualNumber roundTo: 0.01)
		equals: (expectedNumber roundTo: 0.01)
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnEarth [
	self assert: (SpaceAge on: Earth at: 1000000000) closeEnoughTo: 31.69
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnJupiter [
	self assert: (SpaceAge on: Jupiter at: 901876382) closeEnoughTo: 2.41
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnMars [
	self assert: (SpaceAge on: Mars at: 2129871239) closeEnoughTo: 35.88
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnMercury [
	self
		assert: (SpaceAge on: Mercury at: 2134835688)
		closeEnoughTo: 280.88
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnNeptune [
	self
		assert: (SpaceAge on: Neptune at: 1821023456)
		closeEnoughTo: 0.35
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnSaturn [
	self assert: (SpaceAge on: Saturn at: 2000000000) closeEnoughTo: 2.15
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnUranus [
	self assert: (SpaceAge on: Uranus at: 1210123456) closeEnoughTo: 0.46
]

{ #category : #tests }
SpaceAgeTest >> testAgeOnVenus [
	self assert: (SpaceAge on: Venus at: 189839836) closeEnoughTo: 9.78
]
