"
# Bob

Bob is a lackadaisical teenager. In conversation, his responses are very limited.

Bob answers 'Sure.' if you ask him a question.

He answers 'Whoa, chill out!' if you yell at him.

He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

He says 'Fine. Be that way!' if you address him without actually saying
anything.

He answers 'Whatever.' to anything else.

Bob's conversational partner is a purist when it comes to written communication and always follows normal rules regarding sentence punctuation in English.

## Hint

TBD

"
Class {
	#name : #BobTest,
	#superclass : #ExercismTest,
	#instVars : [
		'bobCalculator'
	],
	#category : #'ExercismWIP-Bob'
}

{ #category : #config }
BobTest class >> uuid [
	"Answer a unique id for this exercise"
	^'04f2edd9-2b3f-0d00-a2c6-3e2409f0590c'
]

{ #category : #config }
BobTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.4.0'
]

{ #category : #setup }
BobTest >> setUp [
	bobCalculator := Bob new
]

{ #category : #test }
BobTest >> testAlternateSilence [
	| result |

	result := bobCalculator responseHeyBob: '										' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #test }
BobTest >> testAskingANumericQuestion [
	| result |

	result := bobCalculator responseHeyBob: 'You are, what, like 15?' .
	self assert: result equals: 'Sure.'
]

{ #category : #test }
BobTest >> testAskingAQuestion [
	| result |

	result := bobCalculator responseHeyBob: 'Does this cryogenic chamber make me look fat?' .
	self assert: result equals: 'Sure.'
]

{ #category : #test }
BobTest >> testAskingGibberish [
	| result |

	result := bobCalculator responseHeyBob: 'fffbbcbeab?' .
	self assert: result equals: 'Sure.'
]

{ #category : #test }
BobTest >> testEndingWithWhitespace [
	| result |

	result := bobCalculator responseHeyBob: 'Okay if like my  spacebar  quite a bit?   ' .
	self assert: result equals: 'Sure.'
]

{ #category : #test }
BobTest >> testForcefulQuestion [
	| result |

	result := bobCalculator responseHeyBob: 'WHAT THE HELL WERE YOU THINKING?' .
	self assert: result equals: 'Calm down, I know what I''m doing!'
]

{ #category : #test }
BobTest >> testMultipleLineQuestion [
	| result |

	result := bobCalculator responseHeyBob: '
Does this cryogenic chamber make me look fat?
No.' .
	self assert: result equals: 'Whatever.'
]

{ #category : #test }
BobTest >> testNoLetters [
	| result |

	result := bobCalculator responseHeyBob: '1, 2, 3' .
	self assert: result equals: 'Whatever.'
]

{ #category : #test }
BobTest >> testNonlettersWithQuestion [
	| result |

	result := bobCalculator responseHeyBob: ':) ?' .
	self assert: result equals: 'Sure.'
]

{ #category : #test }
BobTest >> testNonquestionEndingWithWhitespace [
	| result |

	result := bobCalculator responseHeyBob: 'This is a statement ending with whitespace      ' .
	self assert: result equals: 'Whatever.'
]

{ #category : #test }
BobTest >> testOtherWhitespace [
	| result |

	result := bobCalculator responseHeyBob: '

 	' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #test }
BobTest >> testPrattlingOn [
	| result |

	result := bobCalculator responseHeyBob: 'Wait! Hang on. Are you going to be OK?' .
	self assert: result equals: 'Sure.'
]

{ #category : #test }
BobTest >> testProlongedSilence [
	| result |

	result := bobCalculator responseHeyBob: '          ' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #test }
BobTest >> testQuestionWithNoLetters [
	| result |

	result := bobCalculator responseHeyBob: '4?' .
	self assert: result equals: 'Sure.'
]

{ #category : #test }
BobTest >> testShouting [
	| result |

	result := bobCalculator responseHeyBob: 'WATCH OUT!' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #test }
BobTest >> testShoutingGibberish [
	| result |

	result := bobCalculator responseHeyBob: 'FCECDFCAAB' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #test }
BobTest >> testShoutingNumbers [
	| result |

	result := bobCalculator responseHeyBob: '1, 2, 3 GO!' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #test }
BobTest >> testShoutingWithNoExclamationMark [
	| result |

	result := bobCalculator responseHeyBob: 'I HATE THE DMV' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #test }
BobTest >> testShoutingWithSpecialCharacters [
	| result |

	result := bobCalculator responseHeyBob: 'ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #test }
BobTest >> testSilence [
	| result |

	result := bobCalculator responseHeyBob: '' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #test }
BobTest >> testStartingWithWhitespace [
	| result |

	result := bobCalculator responseHeyBob: '         hmmmmmmm...' .
	self assert: result equals: 'Whatever.'
]

{ #category : #test }
BobTest >> testStatementContainingQuestionMark [
	| result |

	result := bobCalculator responseHeyBob: 'Ending with ? means a question.' .
	self assert: result equals: 'Whatever.'
]

{ #category : #test }
BobTest >> testStatingSomething [
	| result |

	result := bobCalculator responseHeyBob: 'Tom-ay-to, tom-aaaah-to.' .
	self assert: result equals: 'Whatever.'
]

{ #category : #test }
BobTest >> testTalkingForcefully [
	| result |

	result := bobCalculator responseHeyBob: 'Let''s go make out behind the gym!' .
	self assert: result equals: 'Whatever.'
]

{ #category : #test }
BobTest >> testUsingAcronymsInRegularSpeech [
	| result |

	result := bobCalculator responseHeyBob: 'It''s OK if you don''t want to go to the DMV.' .
	self assert: result equals: 'Whatever.'
]
