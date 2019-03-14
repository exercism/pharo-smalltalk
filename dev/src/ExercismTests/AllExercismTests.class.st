"
I am a composite test that gathers all the test cases in Exercism so you can easily run them all in a System Browser
"
Class {
	#name : #AllExercismTests,
	#superclass : #TestCase,
	#category : #'ExercismTests-UnitTests'
}

{ #category : #private }
AllExercismTests class >> allExercismTests [
	"gather all the TestCases in the Execercsim package"

	^ self allExercismTestsFor: #( #Exercism #ExercismDev )
]

{ #category : #private }
AllExercismTests class >> allExercismTestsFor: packagesNameList [
	"gather all the TestCases in the Execercsim package"

	^ packagesNameList
		inject: Set new
		into: [ :finalResult :pkgName | 
			(RPackageOrganizer default packageNamed: pkgName) packages
				inject: finalResult
				into: [ :result :pkg | 
					result
						addAll: (pkg classes select: [ :c | c isTestCase ]);
						yourself ] ]
]

{ #category : #private }
AllExercismTests class >> allUserExercismTests [
	"gather all the TestCases in the Execercsim package"

	^ self allExercismTestsFor: #( #Exercism )
]

{ #category : #private }
AllExercismTests class >> suite [
	^ self allExercismTests
		inject: TestSuite new
		into: [ :suite :test | suite addTest: test buildSuiteFromSelectors ]
]

{ #category : #tests }
AllExercismTests >> testAll [
	"Create a suite to eaily run all the tests - this is a stub that gives a browser button 
	to easily click on to run all the composite tests"
	
	^true 
	
]
