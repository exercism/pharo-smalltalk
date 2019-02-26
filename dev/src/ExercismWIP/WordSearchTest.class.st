"
# Word Search

In word search puzzles you get a square of letters and have to find specific
words in them.

For example:

```text
jefblpepre
camdcimgtc
oivokprjsm
pbwasqroua
rixilelhrs
wolcqlirpc
screeaumgr
alxhpburyi
jalaycalmp
clojurermt
```

There are several programming languages hidden in the above square.

Words can be hidden in all kinds of directions: left-to-right, right-to-left,
vertical and diagonal.

Given a puzzle and a list of words return the location of the first and last
letter of each word.

## Hint

TBD

"
Class {
	#name : #WordSearchTest,
	#superclass : #ExercismTest,
	#instVars : [
		'wordSearchCalculator'
	],
	#category : #'ExercismWIP-WordSearch'
}

{ #category : #config }
WordSearchTest class >> uuid [
	"Answer a unique id for this exercise"
	^'86653cda-2b3f-0d00-a310-7a8109f0590c'
]

{ #category : #config }
WordSearchTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.1'
]

{ #category : #setup }
WordSearchTest >> setUp [
	wordSearchCalculator := WordSearch new
]

{ #category : #test }
WordSearchTest >> testShouldAcceptAnInitialGameGridAndATargetSearchWord [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('jefblpepre' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->nil); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldFailToLocateAWordThatIsNotInThePuzzle [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp' 'ruby' 'haskell' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('ecmascript'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->10); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->10); add: ('row'->10); yourself)); yourself)); add: ('haskell'->nil); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); add: ('java'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->4); add: ('row'->4); yourself)); yourself)); add: ('lua'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->8); add: ('row'->9); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->7); yourself)); yourself)); add: ('ruby'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->8); add: ('row'->6); yourself)); add: ('end'->((Dictionary new) add: ('column'->5); add: ('row'->9); yourself)); yourself)); add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('lisp'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->3); add: ('row'->6); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->3); yourself)); yourself)); add: ('rust'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->9); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->9); add: ('row'->2); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateADifferentLeftToRightWord [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('coffee' ) grid: #('coffeelplx' ) .
	self assert: result equals: ((Dictionary new) add: ('coffee'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->1); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateADifferentLeftToRightWordInATenLineGrid [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('fortran' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'fortranftw' 'alxhpburyi' 'clojurermt' 'jalaycalmp' ) .
	self assert: result equals: ((Dictionary new) add: ('fortran'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->7); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->7); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateALeftToRightWordInTenLineGrid [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateALeftToRightWordInThreeLineGrid [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('camdcimgtc' 'jefblpepre' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->3); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->3); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateALeftToRightWordInTwoLineGrid [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('jefblpepre' 'tclojurerm' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->2); add: ('row'->2); yourself)); add: ('end'->((Dictionary new) add: ('column'->8); add: ('row'->2); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateASingleWordWrittenRightToLeft [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('elixir' ) grid: #('rixilelhrs' ) .
	self assert: result equals: ((Dictionary new) add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateMultipleWords [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('fortran' 'clojure' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'fortranftw' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('fortran'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->7); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->7); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateMultipleWordsWrittenInDifferentHorizontalDirections [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('elixir' 'clojure' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateOneWordWrittenLeftToRight [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->1); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateThatDifferentLeftToRightWordInADifferentPosition [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('coffee' ) grid: #('xcoffeezlp' ) .
	self assert: result equals: ((Dictionary new) add: ('coffee'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->2); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->1); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateThatLeftToRightWordInADifferentPositionInATenLineGrid [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'clojurermt' 'jalaycalmp' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->9); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->9); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateTheSameWordWrittenLeftToRightInADifferentPosition [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('mtclojurer' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->3); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->9); add: ('row'->1); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateWordsWrittenBottomLeftToTopRight [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('ecmascript'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->10); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->10); add: ('row'->10); yourself)); yourself)); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); add: ('java'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->4); add: ('row'->4); yourself)); yourself)); add: ('lua'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->8); add: ('row'->9); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->7); yourself)); yourself)); add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('lisp'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->3); add: ('row'->6); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->3); yourself)); yourself)); add: ('rust'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->9); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->9); add: ('row'->2); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateWordsWrittenBottomRightToTopLeft [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('ecmascript'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->10); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->10); add: ('row'->10); yourself)); yourself)); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); add: ('java'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->4); add: ('row'->4); yourself)); yourself)); add: ('lua'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->8); add: ('row'->9); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->7); yourself)); yourself)); add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('rust'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->9); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->9); add: ('row'->2); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateWordsWrittenBottomToTop [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); add: ('ecmascript'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->10); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->10); add: ('row'->10); yourself)); yourself)); add: ('rust'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->9); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->9); add: ('row'->2); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateWordsWrittenTopLeftToBottomRight [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('ecmascript'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->10); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->10); add: ('row'->10); yourself)); yourself)); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); add: ('java'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->4); add: ('row'->4); yourself)); yourself)); add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('rust'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->9); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->9); add: ('row'->2); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateWordsWrittenTopRightToBottomLeft [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp' 'ruby' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('ecmascript'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->10); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->10); add: ('row'->10); yourself)); yourself)); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); add: ('java'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->4); add: ('row'->4); yourself)); yourself)); add: ('lua'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->8); add: ('row'->9); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->7); yourself)); yourself)); add: ('ruby'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->8); add: ('row'->6); yourself)); add: ('end'->((Dictionary new) add: ('column'->5); add: ('row'->9); yourself)); yourself)); add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('lisp'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->3); add: ('row'->6); yourself)); add: ('end'->((Dictionary new) add: ('column'->6); add: ('row'->3); yourself)); yourself)); add: ('rust'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->9); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->9); add: ('row'->2); yourself)); yourself)); yourself)
]

{ #category : #test }
WordSearchTest >> testShouldLocateWordsWrittenTopToBottom [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' ) grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->1); add: ('row'->10); yourself)); add: ('end'->((Dictionary new) add: ('column'->7); add: ('row'->10); yourself)); yourself)); add: ('elixir'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->6); add: ('row'->5); yourself)); add: ('end'->((Dictionary new) add: ('column'->1); add: ('row'->5); yourself)); yourself)); add: ('ecmascript'->((Dictionary new) add: ('start'->((Dictionary new) add: ('column'->10); add: ('row'->1); yourself)); add: ('end'->((Dictionary new) add: ('column'->10); add: ('row'->10); yourself)); yourself)); yourself)
]
