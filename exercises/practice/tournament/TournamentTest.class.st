"
# Tournament

Tally the results of a small football competition.

Based on an input file containing which team played against which and what the
outcome was, create a file with a table like this:

```text
Team                           | MP |  W |  D |  L |  P
Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
Blithering Badgers             |  3 |  1 |  0 |  2 |  3
Courageous Californians        |  3 |  0 |  1 |  2 |  1
```

What do those abbreviations mean?

- MP: Matches Played
- W: Matches Won
- D: Matches Drawn (Tied)
- L: Matches Lost
- P: Points

A win earns a team 3 points. A draw earns 1. A loss earns 0.

The outcome should be ordered by points, descending. In case of a tie, teams are ordered alphabetically.

###

Input

Your tallying program will receive input that looks like:

```text
Allegoric Alaskans;Blithering Badgers;win
Devastating Donkeys;Courageous Californians;draw
Devastating Donkeys;Allegoric Alaskans;win
Courageous Californians;Blithering Badgers;loss
Blithering Badgers;Devastating Donkeys;loss
Allegoric Alaskans;Courageous Californians;win
```

The result of the match refers to the first team listed. So this line

```text
Allegoric Alaskans;Blithering Badgers;win
```

Means that the Allegoric Alaskans beat the Blithering Badgers.

This line:

```text
Courageous Californians;Blithering Badgers;loss
```

Means that the Blithering Badgers beat the Courageous Californians.

And this line:

```text
Devastating Donkeys;Courageous Californians;draw
```

Means that the Devastating Donkeys and Courageous Californians tied.

## Hint

Build up this exercise piece by piece, and don't be afraid to split out any useful concepts into a new class. Previous exercises should give the foundation for a neat solution.

It might also be helpfulnto review chapters on Object Oriented thinking, for example [Inside Smalltalk - Chapter 1](http://sdmeta.gforge.inria.fr/FreeBooks/InsideST/InsideSmalltalk.pdf) or [Smalltalk by Example - Chapter 9](http://sdmeta.gforge.inria.fr/FreeBooks/ByExample/11%20-%20Chapter%209%20-%20Object-Oriente.pdf)


"
Class {
	#name : #TournamentTest,
	#superclass : #ExercismTest,
	#instVars : [
		'tournamentCalculator'
	],
	#category : #'Exercise@Tournament'
}

{ #category : #config }
TournamentTest class >> exercise [
	"Answer the configured exercise meta data for this exercise, an ExercismExercise"
	
	^(self createExerciseAfter: GradeSchoolTest)
		isCore: false;
		difficulty: 5;
		topics: #('sorting' 'filtering' 'iteration' 'parsing' 'transforming' 'object_oriented_programming');
		yourself
]

{ #category : #config }
TournamentTest class >> uuid [
	"Answer a unique id for this exercise"
	^'1109cabb-8040-0d00-810e-7c1b01deb008'
]

{ #category : #config }
TournamentTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.4.0'
]

{ #category : #running }
TournamentTest >> setUp [
	super setUp.
	tournamentCalculator := Tournament new
]

{ #category : #tests }
TournamentTest >> test01_JustTheHeaderIfNoInput [
	| result |

	result := tournamentCalculator tallyRows: #() .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' )
]

{ #category : #tests }
TournamentTest >> test02_AWinIsThreePointsALossIsZeroPoints [
	| result |

	result := tournamentCalculator tallyRows: #('Allegoric Alaskans;Blithering Badgers;win' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3' 'Blithering Badgers             |  1 |  0 |  0 |  1 |  0' )
]

{ #category : #tests }
TournamentTest >> test03_AWinCanAlsoBeExpressedAsALoss [
	| result |

	result := tournamentCalculator tallyRows: #('Blithering Badgers;Allegoric Alaskans;loss' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  1 |  1 |  0 |  0 |  3' 'Blithering Badgers             |  1 |  0 |  0 |  1 |  0' )
]

{ #category : #tests }
TournamentTest >> test04_ADifferentTeamCanWin [
	| result |

	result := tournamentCalculator tallyRows: #('Blithering Badgers;Allegoric Alaskans;win' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Blithering Badgers             |  1 |  1 |  0 |  0 |  3' 'Allegoric Alaskans             |  1 |  0 |  0 |  1 |  0' )
]

{ #category : #tests }
TournamentTest >> test05_ADrawIsOnePointEach [
	| result |

	result := tournamentCalculator tallyRows: #('Allegoric Alaskans;Blithering Badgers;draw' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  1 |  0 |  1 |  0 |  1' 'Blithering Badgers             |  1 |  0 |  1 |  0 |  1' )
]

{ #category : #tests }
TournamentTest >> test06_ThereCanBeMoreThanOneMatch [
	| result |

	result := tournamentCalculator tallyRows: #('Allegoric Alaskans;Blithering Badgers;win' 'Allegoric Alaskans;Blithering Badgers;win' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6' 'Blithering Badgers             |  2 |  0 |  0 |  2 |  0' )
]

{ #category : #tests }
TournamentTest >> test07_ThereCanBeMoreThanOneWinner [
	| result |

	result := tournamentCalculator tallyRows: #('Allegoric Alaskans;Blithering Badgers;loss' 'Allegoric Alaskans;Blithering Badgers;win' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  2 |  1 |  0 |  1 |  3' 'Blithering Badgers             |  2 |  1 |  0 |  1 |  3' )
]

{ #category : #tests }
TournamentTest >> test08_ThereCanBeMoreThanTwoTeams [
	| result |

	result := tournamentCalculator tallyRows: #('Allegoric Alaskans;Blithering Badgers;win' 'Blithering Badgers;Courageous Californians;win' 'Courageous Californians;Allegoric Alaskans;loss' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  2 |  2 |  0 |  0 |  6' 'Blithering Badgers             |  2 |  1 |  0 |  1 |  3' 'Courageous Californians        |  2 |  0 |  0 |  2 |  0' )
]

{ #category : #tests }
TournamentTest >> test09_TypicalInput [
	| result |

	result := tournamentCalculator tallyRows: #('Allegoric Alaskans;Blithering Badgers;win' 'Devastating Donkeys;Courageous Californians;draw' 'Devastating Donkeys;Allegoric Alaskans;win' 'Courageous Californians;Blithering Badgers;loss' 'Blithering Badgers;Devastating Donkeys;loss' 'Allegoric Alaskans;Courageous Californians;win' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Devastating Donkeys            |  3 |  2 |  1 |  0 |  7' 'Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6' 'Blithering Badgers             |  3 |  1 |  0 |  2 |  3' 'Courageous Californians        |  3 |  0 |  1 |  2 |  1' )
]

{ #category : #tests }
TournamentTest >> test10_IncompleteCompetitionnotAllPairsHavePlayed [
	| result |

	result := tournamentCalculator tallyRows: #('Allegoric Alaskans;Blithering Badgers;loss' 'Devastating Donkeys;Allegoric Alaskans;loss' 'Courageous Californians;Blithering Badgers;draw' 'Allegoric Alaskans;Courageous Californians;win' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6' 'Blithering Badgers             |  2 |  1 |  1 |  0 |  4' 'Courageous Californians        |  2 |  0 |  1 |  1 |  1' 'Devastating Donkeys            |  1 |  0 |  0 |  1 |  0' )
]

{ #category : #tests }
TournamentTest >> test11_TiesBrokenAlphabetically [
	| result |

	result := tournamentCalculator tallyRows: #('Courageous Californians;Devastating Donkeys;win' 'Allegoric Alaskans;Blithering Badgers;win' 'Devastating Donkeys;Allegoric Alaskans;loss' 'Courageous Californians;Blithering Badgers;win' 'Blithering Badgers;Devastating Donkeys;draw' 'Allegoric Alaskans;Courageous Californians;draw' ) .
	self assert: result equals: #('Team                           | MP |  W |  D |  L |  P' 'Allegoric Alaskans             |  3 |  2 |  1 |  0 |  7' 'Courageous Californians        |  3 |  2 |  1 |  0 |  7' 'Blithering Badgers             |  3 |  0 |  1 |  2 |  1' 'Devastating Donkeys            |  3 |  0 |  1 |  2 |  1' )
]
