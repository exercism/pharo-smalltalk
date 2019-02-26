"
# Raindrops

Convert a number to a string, the contents of which depend on the number's factors.

- If the number has 3 as a factor, output 'Pling'.
- If the number has 5 as a factor, output 'Plang'.
- If the number has 7 as a factor, output 'Plong'.
- If the number does not have 3, 5, or 7 as a factor,
  just pass the number's digits straight through.

## Examples

- 28's factors are 1, 2, 4, **7**, 14, 28.
  - In raindrop-speak, this would be a simple ""Plong"".
- 30's factors are 1, 2, **3**, **5**, 6, 10, 15, 30.
  - In raindrop-speak, this would be a ""PlingPlang"".
- 34 has four factors: 1, 2, 17, and 34.
  - In raindrop-speak, this would be ""34"".

## Hint

TBD

"
Class {
	#name : #RaindropsTest,
	#superclass : #ExercismTest,
	#instVars : [
		'raindropsCalculator'
	],
	#category : #'ExercismWIP-Raindrops'
}

{ #category : #config }
RaindropsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'a8ea1dda-2b3f-0d00-a2f5-212509f0590c'
]

{ #category : #config }
RaindropsTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
RaindropsTest >> setUp [
	raindropsCalculator := Raindrops new
]

{ #category : #test }
RaindropsTest >> test2ToThePower3DoesNotMakeARaindropSoundAs3IsTheExponentNotTheBase [
	| result |

	result := raindropsCalculator convertNumber: 8 .
	self assert: result equals: '8'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor105IsPlingPlangPlongAsItHasFactors35And7 [
	| result |

	result := raindropsCalculator convertNumber: 105 .
	self assert: result equals: 'PlingPlangPlong'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor10IsPlangAsItHasAFactor5 [
	| result |

	result := raindropsCalculator convertNumber: 10 .
	self assert: result equals: 'Plang'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor14IsPlongAsItHasAFactorOf7 [
	| result |

	result := raindropsCalculator convertNumber: 14 .
	self assert: result equals: 'Plong'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor15IsPlingPlangAsItHasFactors3And5 [
	| result |

	result := raindropsCalculator convertNumber: 15 .
	self assert: result equals: 'PlingPlang'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor1Is1 [
	| result |

	result := raindropsCalculator convertNumber: 1 .
	self assert: result equals: '1'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor21IsPlingPlongAsItHasFactors3And7 [
	| result |

	result := raindropsCalculator convertNumber: 21 .
	self assert: result equals: 'PlingPlong'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor25IsPlangAsItHasAFactor5 [
	| result |

	result := raindropsCalculator convertNumber: 25 .
	self assert: result equals: 'Plang'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor27IsPlingAsItHasAFactor3 [
	| result |

	result := raindropsCalculator convertNumber: 27 .
	self assert: result equals: 'Pling'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor3125IsPlangAsItHasAFactor5 [
	| result |

	result := raindropsCalculator convertNumber: 3125 .
	self assert: result equals: 'Plang'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor35IsPlangPlongAsItHasFactors5And7 [
	| result |

	result := raindropsCalculator convertNumber: 35 .
	self assert: result equals: 'PlangPlong'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor3IsPling [
	| result |

	result := raindropsCalculator convertNumber: 3 .
	self assert: result equals: 'Pling'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor49IsPlongAsItHasAFactor7 [
	| result |

	result := raindropsCalculator convertNumber: 49 .
	self assert: result equals: 'Plong'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor52Is52 [
	| result |

	result := raindropsCalculator convertNumber: 52 .
	self assert: result equals: '52'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor5IsPlang [
	| result |

	result := raindropsCalculator convertNumber: 5 .
	self assert: result equals: 'Plang'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor6IsPlingAsItHasAFactor3 [
	| result |

	result := raindropsCalculator convertNumber: 6 .
	self assert: result equals: 'Pling'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor7IsPlong [
	| result |

	result := raindropsCalculator convertNumber: 7 .
	self assert: result equals: 'Plong'
]

{ #category : #test }
RaindropsTest >> testTheSoundFor9IsPlingAsItHasAFactor3 [
	| result |

	result := raindropsCalculator convertNumber: 9 .
	self assert: result equals: 'Pling'
]
