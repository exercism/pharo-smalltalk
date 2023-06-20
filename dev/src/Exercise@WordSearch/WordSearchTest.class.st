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

A brute force approach using ideas from the RobotSimulator might help.

"
Class {
	#name : #WordSearchTest,
	#superclass : #ExercismTest,
	#instVars : [
		'wordSearchCalculator'
	],
	#category : #'Exercise@WordSearch'
}

{ #category : #config }
WordSearchTest class >> uuid [
	"Answer a unique id for this exercise"
	^'1399d32e-b043-0d00-9289-a7b902a76407'
]

{ #category : #config }
WordSearchTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.2.1'
]

{ #category : #running }
WordSearchTest >> setUp [
	super setUp.
	wordSearchCalculator := WordSearch new
]

{ #category : #tests }
WordSearchTest >> test01_ShouldAcceptAnInitialGameGridAndATargetSearchWord [
	| result |

	result := wordSearchCalculator searchWordsToSearchFor: #('clojure' ) grid: #('jefblpepre' ) .
	self assert: result equals: ((Dictionary new) add: ('clojure'->nil); yourself)
]

{ #category : #tests }
WordSearchTest >> test02_ShouldLocateOneWordWrittenLeftToRight [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure')
		grid: #('clojurermt').
		
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 1;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test03_ShouldLocateTheSameWordWrittenLeftToRightInADifferentPosition [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure')
		grid: #('mtclojurer').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 3;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 1;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test04_ShouldLocateADifferentLeftToRightWord [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('coffee')
		grid: #('coffeelplx').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'coffee'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 1;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test05_ShouldLocateThatDifferentLeftToRightWordInADifferentPosition [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('coffee')
		grid: #('xcoffeezlp').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'coffee'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 2;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 1;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test06_ShouldLocateALeftToRightWordInTwoLineGrid [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure')
		grid: #('jefblpepre' 'tclojurerm').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 2;
												add: 'row' -> 2;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 8;
												add: 'row' -> 2;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test07_ShouldLocateALeftToRightWordInThreeLineGrid [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure')
		grid: #('camdcimgtc' 'jefblpepre' 'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 3;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 3;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test08_ShouldLocateALeftToRightWordInTenLineGrid [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure')
		grid:
			#(
			'jefblpepre' 
			'camdcimgtc' 
			'oivokprjsm' 
			'pbwasqroua' 
			'rixilelhrs' 
			'wolcqlirpc' 
			'screeaumgr' 
			'alxhpburyi' 
			'jalaycalmp' 
			'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test09_ShouldLocateThatLeftToRightWordInADifferentPositionInATenLineGrid [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure')
		grid:
			#('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'clojurermt' 'jalaycalmp').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 9;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 9;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test10_ShouldLocateADifferentLeftToRightWordInATenLineGrid [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('fortran')
		grid:
			#('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'fortranftw' 'alxhpburyi' 'clojurermt' 'jalaycalmp').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'fortran'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 7;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 7;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test11_ShouldLocateMultipleWords [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('fortran' 'clojure')
		grid:
			#('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'fortranftw' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'fortran'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 7;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 7;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test12_ShouldLocateASingleWordWrittenRightToLeft [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('elixir')
		grid: #('rixilelhrs').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test13_ShouldLocateMultipleWordsWrittenInDifferentHorizontalDirections [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('elixir' 'clojure')
		grid:
			#('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test14_ShouldLocateWordsWrittenTopToBottom [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript')
		grid:
			#('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				add:
					'ecmascript'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 10;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test15_ShouldLocateWordsWrittenBottomToTop [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust')
		grid:
			#('jefblpepre' 'camdcimgtc' 'oivokprjsm' 'pbwasqroua' 'rixilelhrs' 'wolcqlirpc' 'screeaumgr' 'alxhpburyi' 'jalaycalmp' 'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				add:
					'ecmascript'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'rust'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 2;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test16_ShouldLocateWordsWrittenTopLeftToBottomRight [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java')
		grid:
			#(
			'jefblpepre' 
			'camdcimgtc' 
			'oivokprjsm' 
			'pbwasqroua' 
			'rixilelhrs' 
			'wolcqlirpc' 
			'screeaumgr' 
			'alxhpburyi' 
			'jalaycalmp' 
			'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'ecmascript'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				add:
					'java'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 4;
												add: 'row' -> 4;
												yourself);
								yourself);
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'rust'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 2;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test17_ShouldLocateWordsWrittenBottomRightToTopLeft [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua')
		grid:
			#(
			'jefblpepre' 
			'camdcimgtc' 
			'oivokprjsm' 
			'pbwasqroua' 
			'rixilelhrs' 
			'wolcqlirpc' 
			'screeaumgr' 
			'alxhpburyi' 
			'jalaycalmp' 
			'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'ecmascript'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				add:
					'java'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 4;
												add: 'row' -> 4;
												yourself);
								yourself);
				add:
					'lua'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 8;
												add: 'row' -> 9;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 7;
												yourself);
								yourself);
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'rust'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 2;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test18_ShouldLocateWordsWrittenBottomLeftToTopRight [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp')
		grid:
			#(
			'jefblpepre' 
			'camdcimgtc' 
			'oivokprjsm' 
			'pbwasqroua' 
			'rixilelhrs' 
			'wolcqlirpc' 
			'screeaumgr' 
			'alxhpburyi' 
			'jalaycalmp' 
			'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'ecmascript'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				add:
					'java'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 4;
												add: 'row' -> 4;
												yourself);
								yourself);
				add:
					'lua'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 8;
												add: 'row' -> 9;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 7;
												yourself);
								yourself);
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'lisp'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 3;
												add: 'row' -> 6;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 3;
												yourself);
								yourself);
				add:
					'rust'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 2;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test19_ShouldLocateWordsWrittenTopRightToBottomLeft [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor: #('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp' 'ruby')
		grid:
			#(
			'jefblpepre' 
			'camdcimgtc' 
			'oivokprjsm' 
			'pbwasqroua' 
			'rixilelhrs' 
			'wolcqlirpc' 
			'screeaumgr' 
			'alxhpburyi' 
			'jalaycalmp' 
			'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'ecmascript'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				add:
					'java'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 4;
												add: 'row' -> 4;
												yourself);
								yourself);
				add:
					'lua'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 8;
												add: 'row' -> 9;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 7;
												yourself);
								yourself);
				add:
					'ruby'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 8;
												add: 'row' -> 6;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 5;
												add: 'row' -> 9;
												yourself);
								yourself);
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'lisp'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 3;
												add: 'row' -> 6;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 3;
												yourself);
								yourself);
				add:
					'rust'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 2;
												yourself);
								yourself);
				yourself)
]

{ #category : #tests }
WordSearchTest >> test20_ShouldFailToLocateAWordThatIsNotInThePuzzle [
	| result |
	result := wordSearchCalculator
		searchWordsToSearchFor:
			#('clojure' 'elixir' 'ecmascript' 'rust' 'java' 'lua' 'lisp' 'ruby' 'haskell')
		grid:
			#(
			'jefblpepre' 
			'camdcimgtc' 
			'oivokprjsm' 
			'pbwasqroua' 
			'rixilelhrs' 
			'wolcqlirpc' 
			'screeaumgr' 
			'alxhpburyi' 
			'jalaycalmp' 
			'clojurermt').
	self
		assert: result
		equals:
			(Dictionary new
				add:
					'ecmascript'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 10;
												add: 'row' -> 10;
												yourself);
								yourself);
				add: 'haskell' -> nil;
				add:
					'elixir'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 5;
												yourself);
								yourself);
				add:
					'java'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 1;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 4;
												add: 'row' -> 4;
												yourself);
								yourself);
				add:
					'lua'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 8;
												add: 'row' -> 9;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 7;
												yourself);
								yourself);
				add:
					'ruby'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 8;
												add: 'row' -> 6;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 5;
												add: 'row' -> 9;
												yourself);
								yourself);
				add:
					'clojure'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 1;
												add: 'row' -> 10;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 7;
												add: 'row' -> 10;
												yourself);
								yourself);
				add:
					'lisp'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 3;
												add: 'row' -> 6;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 6;
												add: 'row' -> 3;
												yourself);
								yourself);
				add:
					'rust'
						->
							(Dictionary new
								add:
									'start'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 5;
												yourself);
								add:
									'end'
										->
											(Dictionary new
												add: 'column' -> 9;
												add: 'row' -> 2;
												yourself);
								yourself);
				yourself)
]
