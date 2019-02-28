"
# Grade School

Given students' names along with the grade that they are in, create a roster
for the school.

In the end, you should be able to:

- Add a student's name to the roster for a grade
  - ""Add Jim to grade 2.""
  - ""OK.""
- Get a list of all students enrolled in a grade
  - ""Which students are in grade 2?""
  - ""We've only got Jim just now.""
- Get a sorted list of all students in all grades.  Grades should sort
  as 1, 2, 3, etc., and students within a grade should be sorted
  alphabetically by name.
  - ""Who all is enrolled in school right now?""
  - ""Grade 1: Anna, Barb, and Charlie. Grade 2: Alex, Peter, and Zoe.
    Grade 3…""

Note that all our students only have one name.  (It's a small town, what
do you want?)

## For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- If you're working in a language with mutable data structures and your
  implementation allows outside code to mutate the school's internal DB
  directly, see if you can prevent this. Feel free to introduce additional
  tests.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?

## Hint

TBD

"
Class {
	#name : #GradeSchoolTest,
	#superclass : #ExercismTest,
	#instVars : [
		'gradeSchoolCalculator'
	],
	#category : #'ExercismWIP-GradeSchool'
}

{ #category : #config }
GradeSchoolTest class >> uuid [
	"Answer a unique id for this exercise"
	^'73438abe-4a3f-0d00-bb5c-593b071d6982'
]

{ #category : #config }
GradeSchoolTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.0.0'
]

{ #category : #setup }
GradeSchoolTest >> setUp [
	gradeSchoolCalculator := GradeSchool new
]

{ #category : #tests }
GradeSchoolTest >> test01_AddingAStudentAddsThemToTheSortedRoster [
	| result |

	result := gradeSchoolCalculator rosterStudents: #(#('Aimee' 2 ) ) .
	self assert: result equals: #('Aimee' )
]

{ #category : #tests }
GradeSchoolTest >> test02_AddingMoreStudentAddsThemToTheSortedRoster [
	| result |

	result := gradeSchoolCalculator rosterStudents: #(#('Blair' 2 ) #('James' 2 ) #('Paul' 2 ) ) .
	self assert: result equals: #('Blair' 'James' 'Paul' )
]

{ #category : #tests }
GradeSchoolTest >> test03_AddingStudentsToDifferentGradesAddsThemToTheSameSortedRoster [
	| result |

	result := gradeSchoolCalculator rosterStudents: #(#('Chelsea' 3 ) #('Logan' 7 ) ) .
	self assert: result equals: #('Chelsea' 'Logan' )
]

{ #category : #tests }
GradeSchoolTest >> test04_RosterReturnsAnEmptyListIfThereAreNoStudentsEnrolled [
	| result |

	result := gradeSchoolCalculator rosterStudents: #() .
	self assert: result equals: #()
]

{ #category : #tests }
GradeSchoolTest >> test05_StudentNamesWithGradesAreDisplayedInTheSameSortedRoster [
	| result |

	result := gradeSchoolCalculator rosterStudents: #(#('Peter' 2 ) #('Anna' 1 ) #('Barb' 1 ) #('Zoe' 2 ) #('Alex' 2 ) #('Jim' 3 ) #('Charlie' 1 ) ) .
	self assert: result equals: #('Anna' 'Barb' 'Charlie' 'Alex' 'Peter' 'Zoe' 'Jim' )
]

{ #category : #tests }
GradeSchoolTest >> test06_GradeReturnsTheStudentsInThatGradeInAlphabeticalOrder [
	| result |

	result := gradeSchoolCalculator gradeDesiredGrade: 5 students: #(#('Franklin' 5 ) #('Bradley' 5 ) #('Jeff' 1 ) ) .
	self assert: result equals: #('Bradley' 'Franklin' )
]

{ #category : #tests }
GradeSchoolTest >> test07_GradeReturnsAnEmptyListIfThereAreNoStudentsInThatGrade [
	| result |

	result := gradeSchoolCalculator gradeDesiredGrade: 1 students: #() .
	self assert: result equals: #()
]
