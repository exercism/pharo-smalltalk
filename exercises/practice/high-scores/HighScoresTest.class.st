"
# High Scores

Manage a game player's High Score list.

Your task is to build a high-score component of the classic Frogger game, one of the highest selling and addictive games of all time, and a classic of the arcade era. Your task is to write methods that return the highest score from the list, the last added score and the three highest scores.

## Hint

This is a nice exercise to just test drive (TDD), and let each test guide your solution


"
Class {
	#name : #HighScoresTest,
	#superclass : #ExercismTest,
	#instVars : [
		'highScoresCalculator'
	],
	#category : #'Exercise@HighScores'
}

{ #category : #config }
HighScoresTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(self createExerciseAfter: ReverseStringTest)
		isCore: false;
		difficulty: 2;
		topics: #('lists' 'sorting' 'filtering');
		yourself
	
				
]

{ #category : #config }
HighScoresTest class >> uuid [
	"Answer a unique id for this exercise"
	^'5f1a9f16-9d41-0d00-8fc2-6a7408866539'
]

{ #category : #config }
HighScoresTest class >> version [
	"Generated from specification: 29 March 2019"
	^'4.0.0'
]

{ #category : #running }
HighScoresTest >> setUp [
	super setUp.
	highScoresCalculator := HighScores new
]

{ #category : #tests }
HighScoresTest >> test01_ListOfScores [
	| result |

	highScoresCalculator addScores: #(30 50 20 70 ).
	result := highScoresCalculator scores.
	self assert: result equals: #(30 50 20 70 )
]

{ #category : #tests }
HighScoresTest >> test02_LatestScore [
	| result |

	highScoresCalculator addScores: #(100 0 90 30 ).
	result := highScoresCalculator latestScore.
	self assert: result equals: 30
]

{ #category : #tests }
HighScoresTest >> test03_PersonalBest [
	| result |

	highScoresCalculator addScores: #(40 100 70 ).
	result := highScoresCalculator personalBestScores.
	self assert: result equals: 100
]

{ #category : #tests }
HighScoresTest >> test04_Top3ScoresPersonalTopThreeFromAListOfScores [
	| result |

	highScoresCalculator addScores: #(10 30 90 30 100 20 10 0 30 40 40 70 70 ) .
	result := highScoresCalculator personalTopThreeScores.
	self assert: result equals: #(100 90 70 )
]

{ #category : #tests }
HighScoresTest >> test05_Top3ScoresPersonalTopHighestToLowest [
	| result |

	highScoresCalculator addScores: #(20 10 30 ).
	result := highScoresCalculator personalTopThreeScores.
	self assert: result equals: #(30 20 10 )
]

{ #category : #tests }
HighScoresTest >> test06_Top3ScoresPersonalTopWhenThereIsATie [
	| result |

	highScoresCalculator addScores: #(40 20 40 30 ).
	result := highScoresCalculator personalTopThreeScores.
	self assert: result equals: #(40 40 30 )
]

{ #category : #tests }
HighScoresTest >> test07_Top3ScoresPersonalTopWhenThereAreLessThan3 [
	| result |

	highScoresCalculator addScores: #(30 70 ).
	result := highScoresCalculator personalTopThreeScores.
	self assert: result equals: #(70 30 )
]

{ #category : #tests }
HighScoresTest >> test08_Top3ScoresPersonalTopWhenThereIsOnlyOne [
	| result |

	highScoresCalculator addScores: #(40 ).
	result := highScoresCalculator personalTopThreeScores.
	self assert: result equals: #(40 )
]

{ #category : #extra }
HighScoresTest >> testLoadMultipleBatchesOfScores [

	highScoresCalculator addScores: #(20 50 40).
	highScoresCalculator addScores: #(30 10).
	self assert: highScoresCalculator latestScore equals: 10.
	self assert: highScoresCalculator personalBestScores equals: 50.
	self assert: highScoresCalculator personalTopThreeScores equals: #(50 40 30)
]

{ #category : #extra }
HighScoresTest >> testPersonalBestWithTies [ 

	| result |
	highScoresCalculator addScores: #(40 100 70 60 100).
	result := highScoresCalculator personalBestScores.
	self assert: result equals: 100
]

{ #category : #extra }
HighScoresTest >> testPersonalTopThreeDoesNotSortStoredScores [
	"Ensure that the process of returning the top three
 does not alter the order of the stored scores."

	| topThree |
	highScoresCalculator addScores: #(1 2 3 4).
	topThree := highScoresCalculator personalTopThreeScores.
	self assert: topThree equals: #(4 3 2).
	self assert: highScoresCalculator latestScore equals: 4
]

{ #category : #extra }
HighScoresTest >> testScoresAreImmutable [
	"Ensure that the collection of scores returned is a copy"

	| scores |
	highScoresCalculator addScores: #(1 2 3 4).
	scores := highScoresCalculator scores.
	scores atLast: 1 put: 5.
	
	"fetch the scores again and verify the first one"
	self assert: highScoresCalculator personalBestScores equals: 4
]
