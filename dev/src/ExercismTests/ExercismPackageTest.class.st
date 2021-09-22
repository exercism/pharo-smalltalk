Class {
	#name : #ExercismPackageTest,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #tests }
ExercismPackageTest >> testExerciseNameOnRPackage [
	self assert: TestExerciseTest package exerciseName equals: 'ExerciseNormal'.
	self assert: HelloWorldTest package exerciseName equals: 'HelloWorld'
]

{ #category : #tests }
ExercismPackageTest >> testExerciseNameOnRPackageTag [

	"Test legacy exerciseNames on RPackageTags"

	self
		assertCollection:
		(self class package classTags collect: #exerciseName)
		includesAny: #( 'UnitTests' #Mock )
]
