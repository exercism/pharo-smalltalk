"
# Markdown

Refactor a Markdown parser.

The markdown exercise is a refactoring exercise. There is code that parses a
given string with [Markdown
syntax](https://guides.github.com/features/mastering-markdown/) and returns the
associated HTML for that string. Even though this code is confusingly written
and hard to follow, somehow it works and all the tests are passing! Your
challenge is to re-write this code to make it easier to read and maintain
while still making sure that all the tests keep passing.

It would be helpful if you made notes of what you did in your refactoring in
comments so reviewers can see that, but it isn't strictly necessary. The most
important thing is to make the code better!

## Hint

TBD

"
Class {
	#name : #MarkdownTest,
	#superclass : #ExercismTest,
	#instVars : [
		'markdownCalculator'
	],
	#category : #'ExercismWIP-Markdown'
}

{ #category : #config }
MarkdownTest class >> uuid [
	"Answer a unique id for this exercise"
	^'3b1ff2d9-2b3f-0d00-a2cb-4a4b09f0590c'
]

{ #category : #config }
MarkdownTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.3.0'
]

{ #category : #setup }
MarkdownTest >> setUp [
	markdownCalculator := Markdown new
]

{ #category : #test }
MarkdownTest >> testMixedNormalItalicsAndBoldText [
	| result |

	result := markdownCalculator parseMarkdown: 'This will _be_ __mixed__' .
	self assert: result equals: '<p>This will <em>be</em> <strong>mixed</strong></p>'
]

{ #category : #test }
MarkdownTest >> testParsesNormalTextAsAParagraph [
	| result |

	result := markdownCalculator parseMarkdown: 'This will be a paragraph' .
	self assert: result equals: '<p>This will be a paragraph</p>'
]

{ #category : #test }
MarkdownTest >> testParsingBoldText [
	| result |

	result := markdownCalculator parseMarkdown: '__This will be bold__' .
	self assert: result equals: '<p><strong>This will be bold</strong></p>'
]

{ #category : #test }
MarkdownTest >> testParsingItalics [
	| result |

	result := markdownCalculator parseMarkdown: '_This will be italic_' .
	self assert: result equals: '<p><em>This will be italic</em></p>'
]

{ #category : #test }
MarkdownTest >> testUnorderedLists [
	| result |

	result := markdownCalculator parseMarkdown: '* Item 1
* Item 2' .
	self assert: result equals: '<ul><li>Item 1</li><li>Item 2</li></ul>'
]

{ #category : #test }
MarkdownTest >> testWithALittleBitOfEverything [
	| result |

	result := markdownCalculator parseMarkdown: '# Header!
* __Bold Item__
* _Italic Item_' .
	self assert: result equals: '<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>'
]

{ #category : #test }
MarkdownTest >> testWithH1HeaderLevel [
	| result |

	result := markdownCalculator parseMarkdown: '# This will be an h1' .
	self assert: result equals: '<h1>This will be an h1</h1>'
]

{ #category : #test }
MarkdownTest >> testWithH2HeaderLevel [
	| result |

	result := markdownCalculator parseMarkdown: '## This will be an h2' .
	self assert: result equals: '<h2>This will be an h2</h2>'
]

{ #category : #test }
MarkdownTest >> testWithH6HeaderLevel [
	| result |

	result := markdownCalculator parseMarkdown: '###### This will be an h6' .
	self assert: result equals: '<h6>This will be an h6</h6>'
]

{ #category : #test }
MarkdownTest >> testWithMarkdownSymbolsInTheHeaderTextThatShouldNotBeInterpreted [
	| result |

	result := markdownCalculator parseMarkdown: '# This is a header with # and * in the text' .
	self assert: result equals: '<h1>This is a header with # and * in the text</h1>'
]

{ #category : #test }
MarkdownTest >> testWithMarkdownSymbolsInTheListItemTextThatShouldNotBeInterpreted [
	| result |

	result := markdownCalculator parseMarkdown: '* Item 1 with a # in the text
* Item 2 with * in the text' .
	self assert: result equals: '<ul><li>Item 1 with a # in the text</li><li>Item 2 with * in the text</li></ul>'
]

{ #category : #test }
MarkdownTest >> testWithMarkdownSymbolsInTheParagraphTextThatShouldNotBeInterpreted [
	| result |

	result := markdownCalculator parseMarkdown: 'This is a paragraph with # and * in the text' .
	self assert: result equals: '<p>This is a paragraph with # and * in the text</p>'
]
