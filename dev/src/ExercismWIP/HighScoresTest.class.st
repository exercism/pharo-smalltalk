"
# High Scores

Manage a game player's High Score list.

Your task is to build a high-score component of the classic Frogger game, one of the highest selling and addictive games of all time, and a classic of the arcade era. Your task is to write methods that return the highest score from the list, the last added score and the three highest scores.

## Hint

TBD

"
Class {
	#name : #HighScoresTest,
	#superclass : #ExercismTest,
	#instVars : [
		'highScoresCalculator'
	],
	#category : #'ExercismWIP-HighScores'
}

{ #category : #config }
HighScoresTest class >> uuid [
	"Answer a unique id for this exercise"
	^'3c1621be-4a3f-0d00-bb13-b757071d6982'
]

{ #category : #config }
HighScoresTest class >> version [
	"Generated from specification: 28 February 2019"
	^'4.0.0'
]

{ #category : #setup }
HighScoresTest >> setUp [
	highScoresCalculator := HighScores new
]

{ #category : #tests }
HighScoresTest >> test01_ListOfScores [
	| result |

	result := highScoresCalculator scores: #(30 50 20 70 ) .
	self assert: result equals: #(30 50 20 70 )
]

{ #category : #tests }
HighScoresTest >> test01_Top3ScoresPersonalTopThreeFromAListOfScores [
	| result |

	result := highScoresCalculator personalTopThreeScores: #(10 30 90 30 100 20 10 0 30 40 40 70 70 ) .
	self assert: result equals: #(100 90 70 )
]

{ #category : #tests }
HighScoresTest >> test02_LatestScore [
	| result |

	result := highScoresCalculator latestScores: #(100 0 90 30 ) .
	self assert: result equals: 30
]

{ #category : #tests }
HighScoresTest >> test02_Top3ScoresPersonalTopHighestToLowest [
	| result |

	result := highScoresCalculator personalTopThreeScores: #(20 10 30 ) .
	self assert: result equals: #(30 20 10 )
]

{ #category : #tests }
HighScoresTest >> test03_PersonalBest [
	| result |

	result := highScoresCalculator personalBestScores: #(40 100 70 ) .
	self assert: result equals: 100
]

{ #category : #tests }
HighScoresTest >> test03_Top3ScoresPersonalTopWhenThereIsATie [
	| result |

	result := highScoresCalculator personalTopThreeScores: #(40 20 40 30 ) .
	self assert: result equals: #(40 40 30 )
]

{ #category : #tests }
HighScoresTest >> test04_Top3ScoresPersonalTopWhenThereAreLessThan3 [
	| result |

	result := highScoresCalculator personalTopThreeScores: #(30 70 ) .
	self assert: result equals: #(70 30 )
]

{ #category : #tests }
HighScoresTest >> test05_Top3ScoresPersonalTopWhenThereIsOnlyOne [
	| result |

	result := highScoresCalculator personalTopThreeScores: #(40 ) .
	self assert: result equals: #(40 )
]
