Class {
	#name : #ExercismConfigGeneratorTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #test }
ExercismConfigGeneratorTest >> testGenerateConfigFrom [
	
	|dirReference cfgFile|
	dirReference := (FileSystem memory root / 'testConfig') ensureCreateDirectory.
	ExercismConfigGenerator generateTo: dirReference.
	cfgFile := (dirReference / 'config.json').
	self assert: cfgFile exists.
	self assert: cfgFile contents notEmpty.
	
]
