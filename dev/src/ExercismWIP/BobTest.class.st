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
	^'bcb53fbe-4a3f-0d00-bb2a-897a071d6982'
]

{ #category : #config }
BobTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.4.0'
]

{ #category : #setup }
BobTest >> setUp [
	bobCalculator := Bob new
]

{ #category : #tests }
BobTest >> test01_StatingSomething [
	| result |

	result := bobCalculator responseHeyBob: 'Tom-ay-to, tom-aaaah-to.' .
	self assert: result equals: 'Whatever.'
]

{ #category : #tests }
BobTest >> test02_Shouting [
	| result |

	result := bobCalculator responseHeyBob: 'WATCH OUT!' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #tests }
BobTest >> test03_ShoutingGibberish [
	| result |

	result := bobCalculator responseHeyBob: 'FCECDFCAAB' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #tests }
BobTest >> test04_AskingAQuestion [
	| result |

	result := bobCalculator responseHeyBob: 'Does this cryogenic chamber make me look fat?' .
	self assert: result equals: 'Sure.'
]

{ #category : #tests }
BobTest >> test05_AskingANumericQuestion [
	| result |

	result := bobCalculator responseHeyBob: 'You are, what, like 15?' .
	self assert: result equals: 'Sure.'
]

{ #category : #tests }
BobTest >> test06_AskingGibberish [
	| result |

	result := bobCalculator responseHeyBob: 'fffbbcbeab?' .
	self assert: result equals: 'Sure.'
]

{ #category : #tests }
BobTest >> test07_TalkingForcefully [
	| result |

	result := bobCalculator responseHeyBob: 'Let''s go make out behind the gym!' .
	self assert: result equals: 'Whatever.'
]

{ #category : #tests }
BobTest >> test08_UsingAcronymsInRegularSpeech [
	| result |

	result := bobCalculator responseHeyBob: 'It''s OK if you don''t want to go to the DMV.' .
	self assert: result equals: 'Whatever.'
]

{ #category : #tests }
BobTest >> test09_ForcefulQuestion [
	| result |

	result := bobCalculator responseHeyBob: 'WHAT THE HELL WERE YOU THINKING?' .
	self assert: result equals: 'Calm down, I know what I''m doing!'
]

{ #category : #tests }
BobTest >> test10_ShoutingNumbers [
	| result |

	result := bobCalculator responseHeyBob: '1, 2, 3 GO!' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #tests }
BobTest >> test11_NoLetters [
	| result |

	result := bobCalculator responseHeyBob: '1, 2, 3' .
	self assert: result equals: 'Whatever.'
]

{ #category : #tests }
BobTest >> test12_QuestionWithNoLetters [
	| result |

	result := bobCalculator responseHeyBob: '4?' .
	self assert: result equals: 'Sure.'
]

{ #category : #tests }
BobTest >> test13_ShoutingWithSpecialCharacters [
	| result |

	result := bobCalculator responseHeyBob: 'ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #tests }
BobTest >> test14_ShoutingWithNoExclamationMark [
	| result |

	result := bobCalculator responseHeyBob: 'I HATE THE DMV' .
	self assert: result equals: 'Whoa, chill out!'
]

{ #category : #tests }
BobTest >> test15_StatementContainingQuestionMark [
	| result |

	result := bobCalculator responseHeyBob: 'Ending with ? means a question.' .
	self assert: result equals: 'Whatever.'
]

{ #category : #tests }
BobTest >> test16_NonlettersWithQuestion [
	| result |

	result := bobCalculator responseHeyBob: ':) ?' .
	self assert: result equals: 'Sure.'
]

{ #category : #tests }
BobTest >> test17_PrattlingOn [
	| result |

	result := bobCalculator responseHeyBob: 'Wait! Hang on. Are you going to be OK?' .
	self assert: result equals: 'Sure.'
]

{ #category : #tests }
BobTest >> test18_Silence [
	| result |

	result := bobCalculator responseHeyBob: '' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #tests }
BobTest >> test19_ProlongedSilence [
	| result |

	result := bobCalculator responseHeyBob: '          ' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #tests }
BobTest >> test20_AlternateSilence [
	| result |

	result := bobCalculator responseHeyBob: '										' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #tests }
BobTest >> test21_MultipleLineQuestion [
	| result |

	result := bobCalculator responseHeyBob: '
Does this cryogenic chamber make me look fat?
No.' .
	self assert: result equals: 'Whatever.'
]

{ #category : #tests }
BobTest >> test22_StartingWithWhitespace [
	| result |

	result := bobCalculator responseHeyBob: '         hmmmmmmm...' .
	self assert: result equals: 'Whatever.'
]

{ #category : #tests }
BobTest >> test23_EndingWithWhitespace [
	| result |

	result := bobCalculator responseHeyBob: 'Okay if like my  spacebar  quite a bit?   ' .
	self assert: result equals: 'Sure.'
]

{ #category : #tests }
BobTest >> test24_OtherWhitespace [
	| result |

	result := bobCalculator responseHeyBob: '

 	' .
	self assert: result equals: 'Fine. Be that way!'
]

{ #category : #tests }
BobTest >> test25_NonquestionEndingWithWhitespace [
	| result |

	result := bobCalculator responseHeyBob: 'This is a statement ending with whitespace      ' .
	self assert: result equals: 'Whatever.'
]
