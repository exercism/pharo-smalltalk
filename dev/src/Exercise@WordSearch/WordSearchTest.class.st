"
# WordSearch

# Description

In word search puzzles you get a square of letters and have to find specific words in them.

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

Words can be hidden in all kinds of directions: left-to-right, right-to-left, vertical and diagonal.

Given a puzzle and a list of words return the location of the first and last letter of each word.

## Hint

2-dimensional array and Point class might be your friends here. Also, search result needs to be in desired format for unit tests, so separate class definition might be needed for word search results.

"
Class {
	#name : 'WordSearchTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'wordSearch'
	],
	#category : 'Exercise@WordSearch',
	#package : 'Exercise@WordSearch'
}

{ #category : 'config' }
WordSearchTest class >> exercise [
	
	^ (ExercismExercise for: self)
			difficulty: 6;
			topics: #('arrays' 'dictionary' 'strings' 'iteration' 'extension-methods' 'points');
			yourself
]

{ #category : 'config' }
WordSearchTest class >> uuid [
	"Answer a unique id for this exercise"
	^'152deac5-8e81-401c-8a6a-b89c2a84c91c'
	  
]

{ #category : 'config' }
WordSearchTest class >> version [
	"Generated from specification: 3 March 2025"
	^'Not specified'
]

{ #category : 'running' }
WordSearchTest >> setUp [
	super setUp.
	wordSearch := WordSearch new
]

{ #category : 'tests' }
WordSearchTest >> test01_ShouldAcceptAnInitialGameGridAndATargetSearchWord [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'Should accept an initial game grid and a target search word'>
	<exeTestUUID: 'b4057815-0d01-41f0-9119-6a91f54b2a0a'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure') grid: #('jefblpepre') .
	self assert: (result at: 'clojure') isNil.
]

{ #category : 'tests' }
WordSearchTest >> test02_ShouldLocateOneWordWrittenLeftToRight [
	<exeTestName: 'Should locate one word written left to right'>
	<exeTestUUID: '6b22bcc5-6cbf-4674-931b-d2edbff73132'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure') grid: #('clojurermt').
	self assert: (result at: 'clojure') start row equals: 1.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 1.
	self assert: (result at: 'clojure') end column equals: 7.
]

{ #category : 'tests' }
WordSearchTest >> test03_ShouldLocateTheSameWordWrittenLeftToRightInADifferentPosition [
	<exeTestName: 'Should locate the same word written left to right in a different position'>
	<exeTestUUID: 'ff462410-434b-442d-9bc3-3360c75f34a8'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure') grid: #('mtclojurer') .
	self assert: (result at: 'clojure') start row equals: 1.
	self assert: (result at: 'clojure') start column equals: 3.
	self assert: (result at: 'clojure') end row equals: 1.
	self assert: (result at: 'clojure') end column equals: 9.
	
]

{ #category : 'tests' }
WordSearchTest >> test04_ShouldLocateADifferentLeftToRightWord [
	<exeTestName: 'Should locate a different left to right word'>
	<exeTestUUID: 'a02febae-6347-443e-b99c-ab0afb0b8fca'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('coffee') grid: #('coffeelplx').
	self assert: (result at: 'coffee') start row equals: 1.
	self assert: (result at: 'coffee') start column equals: 1.
	self assert: (result at: 'coffee') end row equals: 1.
	self assert: (result at: 'coffee') end column equals: 6.
]

{ #category : 'tests' }
WordSearchTest >> test05_ShouldLocateThatDifferentLeftToRightWordInADifferentPosition [
	<exeTestName: 'Should locate that different left to right word in a different position'>
	<exeTestUUID: 'e42e9987-6304-4e13-8232-fa07d5280130'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('coffee') grid: #('xcoffeezlp').
	self assert: (result at: 'coffee') start row equals: 1.
	self assert: (result at: 'coffee') start column equals: 2.
	self assert: (result at: 'coffee') end row equals: 1.
	self assert: (result at: 'coffee') end column equals: 7.

]

{ #category : 'tests' }
WordSearchTest >> test06_ShouldLocateALeftToRightWordInTwoLineGrid [
	<exeTestName: 'Should locate a left to right word in two line grid'>
	<exeTestUUID: '9bff3cee-49b9-4775-bdfb-d55b43a70b2f'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure') grid: #('jefblpepre' 'tclojurerm').
	self assert: (result at: 'clojure') start row equals: 2.
	self assert: (result at: 'clojure') start column equals: 2.
	self assert: (result at: 'clojure') end row equals: 2.
	self assert: (result at: 'clojure') end column equals: 8.

]

{ #category : 'tests' }
WordSearchTest >> test07_ShouldLocateALeftToRightWordInThreeLineGrid [
	<exeTestName: 'Should locate a left to right word in three line grid'>
	<exeTestUUID: '851a35fb-f499-4ec1-9581-395a87903a22'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure') grid: #('camdcimgtc' 'jefblpepre' 'clojurermt') .
	self assert: (result at: 'clojure') start row equals: 3.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 3.
	self assert: (result at: 'clojure') end column equals: 7.

]

{ #category : 'tests' }
WordSearchTest >> test08_ShouldLocateALeftToRightWordInTenLineGrid [
	<exeTestName: 'Should locate a left to right word in ten line grid'>
	<exeTestUUID: '2f3dcf84-ba7d-4b75-8b8d-a3672b32c035'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.

]

{ #category : 'tests' }
WordSearchTest >> test09_ShouldLocateThatLeftToRightWordInADifferentPositionInATenLineGrid [
	<exeTestName: 'Should locate that left to right word in a different position in a ten line grid'>
	<exeTestUUID: '006d4856-f365-4e84-a18c-7d129ce9eefb'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'clojurermt' 'jalaycalmp').
	self assert: (result at: 'clojure') start row equals: 9.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 9.
	self assert: (result at: 'clojure') end column equals: 7.

]

{ #category : 'tests' }
WordSearchTest >> test10_ShouldLocateADifferentLeftToRightWordInATenLineGrid [
	<exeTestName: 'Should locate a different left to right word in a ten line grid'>
	<exeTestUUID: 'eff7ac9f-ff11-443e-9747-40850c12ab60'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('fortran') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'fortranftw' 'alxhpburyi' 'clojurermt' 'jalaycalmp').
	self assert: (result at: 'fortran') start row equals: 7.
	self assert: (result at: 'fortran') start column equals: 1.
	self assert: (result at: 'fortran') end row equals: 7.
	self assert: (result at: 'fortran') end column equals: 7.

]

{ #category : 'tests' }
WordSearchTest >> test11_ShouldLocateMultipleWords [
	<exeTestName: 'Should locate multiple words'>
	<exeTestUUID: 'dea39f86-8c67-4164-8884-13bfc48bd13b'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('fortran' 'clojure') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'fortranftw' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.

	self assert: (result at: 'fortran') start row equals: 7.
	self assert: (result at: 'fortran') start column equals: 1.
	self assert: (result at: 'fortran') end row equals: 7.
	self assert: (result at: 'fortran') end column equals: 7.

]

{ #category : 'tests' }
WordSearchTest >> test12_ShouldLocateASingleWordWrittenRightToLeft [
	<exeTestName: 'Should locate a single word written right to left'>
	<exeTestUUID: '29e6a6a5-f80c-48a6-8e68-05bbbe187a09'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('elixir') grid: #('rixilelhrs').
	self assert: (result at: 'elixir') start row equals: 1.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 1.
	self assert: (result at: 'elixir') end column equals: 1.

]

{ #category : 'tests' }
WordSearchTest >> test13_ShouldLocateMultipleWordsWrittenInDifferentHorizontalDirections [
	<exeTestName: 'Should locate multiple words written in different horizontal directions'>
	<exeTestUUID: '3cf34428-b43f-48b6-b332-ea0b8836011d'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('elixir' 'clojure') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.

]

{ #category : 'tests' }
WordSearchTest >> test14_ShouldLocateWordsWrittenTopToBottom [
	<exeTestName: 'Should locate words written top to bottom'>
	<exeTestUUID: '2c8cd344-a02f-464b-93b6-8bf1bd890003'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.
	
	self assert: (result at: 'ecmascript') start row equals: 1.
	self assert: (result at: 'ecmascript') start column equals: 10.
	self assert: (result at: 'ecmascript') end row equals: 10.
	self assert: (result at: 'ecmascript') end column equals: 10.

]

{ #category : 'tests' }
WordSearchTest >> test15_ShouldLocateWordsWrittenBottomToTop [
	<exeTestName: 'Should locate words written bottom to top'>
	<exeTestUUID: '9ee1e43d-e59d-4c32-9a5f-6a22d4a1550f'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.
	
	self assert: (result at: 'ecmascript') start row equals: 1.
	self assert: (result at: 'ecmascript') start column equals: 10.
	self assert: (result at: 'ecmascript') end row equals: 10.
	self assert: (result at: 'ecmascript') end column equals: 10.

	self assert: (result at: 'rust') start row equals: 5.
	self assert: (result at: 'rust') start column equals: 9.
	self assert: (result at: 'rust') end row equals: 2.
	self assert: (result at: 'rust') end column equals: 9.	

]

{ #category : 'tests' }
WordSearchTest >> test16_ShouldLocateWordsWrittenTopLeftToBottomRight [
	<exeTestName: 'Should locate words written top left to bottom right'>
	<exeTestUUID: '6a21a676-f59e-4238-8e88-9f81015afae9'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.
	
	self assert: (result at: 'ecmascript') start row equals: 1.
	self assert: (result at: 'ecmascript') start column equals: 10.
	self assert: (result at: 'ecmascript') end row equals: 10.
	self assert: (result at: 'ecmascript') end column equals: 10.

	self assert: (result at: 'rust') start row equals: 5.
	self assert: (result at: 'rust') start column equals: 9.
	self assert: (result at: 'rust') end row equals: 2.
	self assert: (result at: 'rust') end column equals: 9.
	
	self assert: (result at: 'java') start row equals: 1.
	self assert: (result at: 'java') start column equals: 1.
	self assert: (result at: 'java') end row equals: 4.
	self assert: (result at: 'java') end column equals: 4.

]

{ #category : 'tests' }
WordSearchTest >> test17_ShouldLocateWordsWrittenBottomRightToTopLeft [
	<exeTestName: 'Should locate words written bottom right to top left'>
	<exeTestUUID: 'c9125189-1861-4b0d-a14e-ba5dab29ca7c'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.
	
	self assert: (result at: 'ecmascript') start row equals: 1.
	self assert: (result at: 'ecmascript') start column equals: 10.
	self assert: (result at: 'ecmascript') end row equals: 10.
	self assert: (result at: 'ecmascript') end column equals: 10.

	self assert: (result at: 'rust') start row equals: 5.
	self assert: (result at: 'rust') start column equals: 9.
	self assert: (result at: 'rust') end row equals: 2.
	self assert: (result at: 'rust') end column equals: 9.
	
	self assert: (result at: 'java') start row equals: 1.
	self assert: (result at: 'java') start column equals: 1.
	self assert: (result at: 'java') end row equals: 4.
	self assert: (result at: 'java') end column equals: 4.
	
	self assert: (result at: 'lua') start row equals: 9.
	self assert: (result at: 'lua') start column equals: 8.
	self assert: (result at: 'lua') end row equals: 7.
	self assert: (result at: 'lua') end column equals: 6.

]

{ #category : 'tests' }
WordSearchTest >> test18_ShouldLocateWordsWrittenBottomLeftToTopRight [
	<exeTestName: 'Should locate words written bottom left to top right'>
	<exeTestUUID: 'b19e2149-7fc5-41ec-a8a9-9bc6c6c38c40'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.
	
	self assert: (result at: 'ecmascript') start row equals: 1.
	self assert: (result at: 'ecmascript') start column equals: 10.
	self assert: (result at: 'ecmascript') end row equals: 10.
	self assert: (result at: 'ecmascript') end column equals: 10.

	self assert: (result at: 'rust') start row equals: 5.
	self assert: (result at: 'rust') start column equals: 9.
	self assert: (result at: 'rust') end row equals: 2.
	self assert: (result at: 'rust') end column equals: 9.
	
	self assert: (result at: 'java') start row equals: 1.
	self assert: (result at: 'java') start column equals: 1.
	self assert: (result at: 'java') end row equals: 4.
	self assert: (result at: 'java') end column equals: 4.
	
	self assert: (result at: 'lua') start row equals: 9.
	self assert: (result at: 'lua') start column equals: 8.
	self assert: (result at: 'lua') end row equals: 7.
	self assert: (result at: 'lua') end column equals: 6.

	self assert: (result at: 'lisp') start row equals: 6.
	self assert: (result at: 'lisp') start column equals: 3.
	self assert: (result at: 'lisp') end row equals: 3.
	self assert: (result at: 'lisp') end column equals: 6.

]

{ #category : 'tests' }
WordSearchTest >> test19_ShouldLocateWordsWrittenTopRightToBottomLeft [
	<exeTestName: 'Should locate words written top right to bottom left'>
	<exeTestUUID: '69e1d994-a6d7-4e24-9b5a-db76751c2ef8'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp' 'ruby') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.
	
	self assert: (result at: 'ecmascript') start row equals: 1.
	self assert: (result at: 'ecmascript') start column equals: 10.
	self assert: (result at: 'ecmascript') end row equals: 10.
	self assert: (result at: 'ecmascript') end column equals: 10.

	self assert: (result at: 'rust') start row equals: 5.
	self assert: (result at: 'rust') start column equals: 9.
	self assert: (result at: 'rust') end row equals: 2.
	self assert: (result at: 'rust') end column equals: 9.
	
	self assert: (result at: 'java') start row equals: 1.
	self assert: (result at: 'java') start column equals: 1.
	self assert: (result at: 'java') end row equals: 4.
	self assert: (result at: 'java') end column equals: 4.
	
	self assert: (result at: 'lua') start row equals: 9.
	self assert: (result at: 'lua') start column equals: 8.
	self assert: (result at: 'lua') end row equals: 7.
	self assert: (result at: 'lua') end column equals: 6.

	self assert: (result at: 'lisp') start row equals: 6.
	self assert: (result at: 'lisp') start column equals: 3.
	self assert: (result at: 'lisp') end row equals: 3.
	self assert: (result at: 'lisp') end column equals: 6.

	self assert: (result at: 'ruby') start row equals: 6.
	self assert: (result at: 'ruby') start column equals: 8.
	self assert: (result at: 'ruby') end row equals: 9.
	self assert: (result at: 'ruby') end column equals: 5.

]

{ #category : 'tests' }
WordSearchTest >> test20_ShouldFailToLocateAWordThatIsNotInThePuzzle [
	<exeTestName: 'Should fail to locate a word that is not in the puzzle'>
	<exeTestUUID: '695531db-69eb-463f-8bad-8de3bf5ef198'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp' 'ruby' 'haskell') grid: #('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self assert: (result at: 'clojure') start row equals: 10.
	self assert: (result at: 'clojure') start column equals: 1.
	self assert: (result at: 'clojure') end row equals: 10.
	self assert: (result at: 'clojure') end column equals: 7.
	
	self assert: (result at: 'elixir') start row equals: 5.
	self assert: (result at: 'elixir') start column equals: 6.
	self assert: (result at: 'elixir') end row equals: 5.
	self assert: (result at: 'elixir') end column equals: 1.
	
	self assert: (result at: 'ecmascript') start row equals: 1.
	self assert: (result at: 'ecmascript') start column equals: 10.
	self assert: (result at: 'ecmascript') end row equals: 10.
	self assert: (result at: 'ecmascript') end column equals: 10.

	self assert: (result at: 'rust') start row equals: 5.
	self assert: (result at: 'rust') start column equals: 9.
	self assert: (result at: 'rust') end row equals: 2.
	self assert: (result at: 'rust') end column equals: 9.
	
	self assert: (result at: 'java') start row equals: 1.
	self assert: (result at: 'java') start column equals: 1.
	self assert: (result at: 'java') end row equals: 4.
	self assert: (result at: 'java') end column equals: 4.
	
	self assert: (result at: 'lua') start row equals: 9.
	self assert: (result at: 'lua') start column equals: 8.
	self assert: (result at: 'lua') end row equals: 7.
	self assert: (result at: 'lua') end column equals: 6.

	self assert: (result at: 'lisp') start row equals: 6.
	self assert: (result at: 'lisp') start column equals: 3.
	self assert: (result at: 'lisp') end row equals: 3.
	self assert: (result at: 'lisp') end column equals: 6.

	self assert: (result at: 'ruby') start row equals: 6.
	self assert: (result at: 'ruby') start column equals: 8.
	self assert: (result at: 'ruby') end row equals: 9.
	self assert: (result at: 'ruby') end column equals: 5.

	self assert: (result at: 'haskell') isNil.

]

{ #category : 'tests' }
WordSearchTest >> test21_ShouldFailToLocateWordsThatAreNotOnHorizontalVerticalOrDiagonalLines [
	<exeTestName: 'Should fail to locate words that are not on horizontal, vertical, or diagonal lines'>
	<exeTestUUID: 'fda5b937-6774-4a52-8f89-f64ed833b175'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('aef' 'ced' 'abf' 'cbd') grid: #('abc' 'def').
	self assert: (result at: 'aef') isNil.
	self assert: (result at: 'abf') isNil.
	self assert: (result at: 'ced') isNil.
	self assert: (result at: 'cbd') isNil.

]

{ #category : 'tests' }
WordSearchTest >> test22_ShouldNotConcatenateDifferentLinesToFindAHorizontalWord [
	<exeTestName: 'Should not concatenate different lines to find a horizontal word'>
	<exeTestUUID: '5b6198eb-2847-4e2f-8efe-65045df16bd3'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('elixir') grid: #('abceli' 'xirdfg').
	self assert: (result at: 'elixir') isNil.

]

{ #category : 'tests' }
WordSearchTest >> test23_ShouldNotWrapAroundHorizontallyToFindAWord [
	<exeTestName: 'Should not wrap around horizontally to find a word'>
	<exeTestUUID: 'eba44139-a34f-4a92-98e1-bd5f259e5769'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('lisp') grid: #('silabcdefp').
	self assert: (result at: 'list') isNil.

]

{ #category : 'tests' }
WordSearchTest >> test24_ShouldNotWrapAroundVerticallyToFindAWord [
	<exeTestName: 'Should not wrap around vertically to find a word'>
	<exeTestUUID: 'cd1f0fa8-76af-4167-b105-935f78364dac'>

	| result |

	result := wordSearch searchWordsToSearchFor: #('rust') grid: #('s' 'u' 'r' 'a' 'b' 'c' 't').
	self assert: (result at: 'rust') isNil.

]
