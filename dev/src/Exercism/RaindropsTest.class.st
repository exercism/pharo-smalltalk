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
	#category : #'Exercism-Raindrops'
}

{ #category : #config }
RaindropsTest class >> difficulty [
	"Answer an Integer, the difficulty level of the test, 1=easy, 10=hard"
	
	^1
]

{ #category : #config }
RaindropsTest class >> topics [
	"Answer a String Array of topics that classify the exercise.
	Topics are commonly found in (but not limited to): 
		https://github.com/exercism/problem-specifications/blob/master/TOPICS.txt"
		
	^#('strings' 'conditionals' 'logic')
	
]

{ #category : #config }
RaindropsTest class >> unlockedBy [
	"Answer the exercise this is dependent on (if core, this is the exercise this one should appear after in the config.json)"
	
	^LeapTest
]

{ #category : #config }
RaindropsTest class >> uuid [
	"Answer a unique id for this exercise"
	^'c0bcb6c5-3f3f-0d00-995d-a4720043fb1f'
]

{ #category : #config }
RaindropsTest class >> version [
	"Generated from specification: 27 February 2019"
	^'1.1.0'
]

{ #category : #setup }
RaindropsTest >> setUp [
	raindropsCalculator := Raindrops new
]

{ #category : #tests }
RaindropsTest >> test01_TheSoundFor1Is1 [
	| result |

	result := raindropsCalculator convertNumber: 1 .
	self assert: result equals: '1'
]

{ #category : #tests }
RaindropsTest >> test02_TheSoundFor3IsPling [
	| result |

	result := raindropsCalculator convertNumber: 3 .
	self assert: result equals: 'Pling'
]

{ #category : #tests }
RaindropsTest >> test03_TheSoundFor5IsPlang [
	| result |

	result := raindropsCalculator convertNumber: 5 .
	self assert: result equals: 'Plang'
]

{ #category : #tests }
RaindropsTest >> test04_TheSoundFor7IsPlong [
	| result |

	result := raindropsCalculator convertNumber: 7 .
	self assert: result equals: 'Plong'
]

{ #category : #tests }
RaindropsTest >> test05_TheSoundFor6IsPlingAsItHasAFactor3 [
	| result |

	result := raindropsCalculator convertNumber: 6 .
	self assert: result equals: 'Pling'
]

{ #category : #tests }
RaindropsTest >> test06_2ToThePower3DoesNotMakeARaindropSoundAs3IsTheExponentNotTheBase [
	| result |

	result := raindropsCalculator convertNumber: 8 .
	self assert: result equals: '8'
]

{ #category : #tests }
RaindropsTest >> test07_TheSoundFor9IsPlingAsItHasAFactor3 [
	| result |

	result := raindropsCalculator convertNumber: 9 .
	self assert: result equals: 'Pling'
]

{ #category : #tests }
RaindropsTest >> test08_TheSoundFor10IsPlangAsItHasAFactor5 [
	| result |

	result := raindropsCalculator convertNumber: 10 .
	self assert: result equals: 'Plang'
]

{ #category : #tests }
RaindropsTest >> test09_TheSoundFor14IsPlongAsItHasAFactorOf7 [
	| result |

	result := raindropsCalculator convertNumber: 14 .
	self assert: result equals: 'Plong'
]

{ #category : #tests }
RaindropsTest >> test10_TheSoundFor15IsPlingPlangAsItHasFactors3And5 [
	| result |

	result := raindropsCalculator convertNumber: 15 .
	self assert: result equals: 'PlingPlang'
]

{ #category : #tests }
RaindropsTest >> test11_TheSoundFor21IsPlingPlongAsItHasFactors3And7 [
	| result |

	result := raindropsCalculator convertNumber: 21 .
	self assert: result equals: 'PlingPlong'
]

{ #category : #tests }
RaindropsTest >> test12_TheSoundFor25IsPlangAsItHasAFactor5 [
	| result |

	result := raindropsCalculator convertNumber: 25 .
	self assert: result equals: 'Plang'
]

{ #category : #tests }
RaindropsTest >> test13_TheSoundFor27IsPlingAsItHasAFactor3 [
	| result |

	result := raindropsCalculator convertNumber: 27 .
	self assert: result equals: 'Pling'
]

{ #category : #tests }
RaindropsTest >> test14_TheSoundFor35IsPlangPlongAsItHasFactors5And7 [
	| result |

	result := raindropsCalculator convertNumber: 35 .
	self assert: result equals: 'PlangPlong'
]

{ #category : #tests }
RaindropsTest >> test15_TheSoundFor49IsPlongAsItHasAFactor7 [
	| result |

	result := raindropsCalculator convertNumber: 49 .
	self assert: result equals: 'Plong'
]

{ #category : #tests }
RaindropsTest >> test16_TheSoundFor52Is52 [
	| result |

	result := raindropsCalculator convertNumber: 52 .
	self assert: result equals: '52'
]

{ #category : #tests }
RaindropsTest >> test17_TheSoundFor105IsPlingPlangPlongAsItHasFactors35And7 [
	| result |

	result := raindropsCalculator convertNumber: 105 .
	self assert: result equals: 'PlingPlangPlong'
]

{ #category : #tests }
RaindropsTest >> test18_TheSoundFor3125IsPlangAsItHasAFactor5 [
	| result |

	result := raindropsCalculator convertNumber: 3125 .
	self assert: result equals: 'Plang'
]
