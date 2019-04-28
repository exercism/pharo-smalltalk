"
I model the Grade School problem, by holding Students as an Association in a sorted list. Note: in this implementation I haven't bothered  using any accessor methods and have kept everything strictly private, as well as answering copies of the internal data.
"
Class {
	#name : #GradeSchool,
	#superclass : #Object,
	#instVars : [
		'students'
	],
	#category : #'Exercism@GradeSchool'
}

{ #category : #helper }
GradeSchool >> addAllStudents: aCollection [
	"Internal - keep the students in a sorted list, specified by a sortBlock"
	
	students := SortedCollection
		sortBlock: [ :studentData1 :studentData2 | 
			studentData1 value < studentData2 value
				or: [ studentData1 value = studentData2 value
						and: [ studentData1 key < studentData2 key ] ] ].

	aCollection
		do: [ :details | self addName: details first grade: details last ].

	^ students
]

{ #category : #helper }
GradeSchool >> addName: nameString grade: gradeInteger [ 
	students add: nameString->gradeInteger
]

{ #category : #exercism }
GradeSchool >> addStudents: aCollection [
	^ self formatResult: (self addAllStudents: aCollection)
]

{ #category : #exercism }
GradeSchool >> desiredGrade: gradeInteger [
	"Answer the Collection of students filtered by grade, alphabetically"
	
	^ self
		formatResult:
			(students select: [ :studentData | studentData value = gradeInteger ])
]

{ #category : #helper }
GradeSchool >> formatResult: aCollection [
	^ (aCollection collect: [ :studentData | studentData key ]) asArray
]

{ #category : #exercism }
GradeSchool >> roster [
	"Answer the Collection of student names, sorted by grade, alphabetically"
	
	^self formatResult: students
]
