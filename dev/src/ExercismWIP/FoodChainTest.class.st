"
# Food Chain

Generate the lyrics of the song 'I Know an Old Lady Who Swallowed a Fly'.

While you could copy/paste the lyrics,
or read them from a file, this problem is much more
interesting if you approach it algorithmically.

This is a [cumulative song](http://en.wikipedia.org/wiki/Cumulative_song) of unknown origin.

This is one of many common variants.

```text
I know an old lady who swallowed a fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a spider.
It wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a bird.
How absurd to swallow a bird!
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a cat.
Imagine that, to swallow a cat!
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a dog.
What a hog, to swallow a dog!
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a goat.
Just opened her throat and swallowed a goat!
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a cow.
I don't know how she swallowed a cow!
She swallowed the cow to catch the goat.
She swallowed the goat to catch the dog.
She swallowed the dog to catch the cat.
She swallowed the cat to catch the bird.
She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
She swallowed the spider to catch the fly.
I don't know why she swallowed the fly. Perhaps she'll die.

I know an old lady who swallowed a horse.
She's dead, of course!
```

## Hint

TBD

"
Class {
	#name : 'FoodChainTest',
	#superclass : 'ExercismTest',
	#instVars : [
		'foodChainCalculator'
	],
	#category : 'ExercismWIP-FoodChain',
	#package : 'ExercismWIP',
	#tag : 'FoodChain'
}

{ #category : 'config' }
FoodChainTest class >> uuid [
	"Answer a unique id for this exercise"
	^'de39d42e-b043-0d00-928a-7ef602a76407'
]

{ #category : 'config' }
FoodChainTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.1.0'
]

{ #category : 'running' }
FoodChainTest >> setUp [
	super setUp.
	foodChainCalculator := FoodChain new
]

{ #category : 'tests' }
FoodChainTest >> test01_Fly [
	| result |

	result := foodChainCalculator reciteStartVerse: 1 endVerse: 1 .
	self assert: result equals: #('I know an old lady who swallowed a fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test02_Spider [
	| result |

	result := foodChainCalculator reciteStartVerse: 2 endVerse: 2 .
	self assert: result equals: #('I know an old lady who swallowed a spider.' 'It wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test03_Bird [
	| result |

	result := foodChainCalculator reciteStartVerse: 3 endVerse: 3 .
	self assert: result equals: #('I know an old lady who swallowed a bird.' 'How absurd to swallow a bird!' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test04_Cat [
	| result |

	result := foodChainCalculator reciteStartVerse: 4 endVerse: 4 .
	self assert: result equals: #('I know an old lady who swallowed a cat.' 'Imagine that, to swallow a cat!' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test05_Dog [
	| result |

	result := foodChainCalculator reciteStartVerse: 5 endVerse: 5 .
	self assert: result equals: #('I know an old lady who swallowed a dog.' 'What a hog, to swallow a dog!' 'She swallowed the dog to catch the cat.' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test06_Goat [
	| result |

	result := foodChainCalculator reciteStartVerse: 6 endVerse: 6 .
	self assert: result equals: #('I know an old lady who swallowed a goat.' 'Just opened her throat and swallowed a goat!' 'She swallowed the goat to catch the dog.' 'She swallowed the dog to catch the cat.' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test07_Cow [
	| result |

	result := foodChainCalculator reciteStartVerse: 7 endVerse: 7 .
	self assert: result equals: #('I know an old lady who swallowed a cow.' 'I don''t know how she swallowed a cow!' 'She swallowed the cow to catch the goat.' 'She swallowed the goat to catch the dog.' 'She swallowed the dog to catch the cat.' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test08_Horse [
	| result |

	result := foodChainCalculator reciteStartVerse: 8 endVerse: 8 .
	self assert: result equals: #('I know an old lady who swallowed a horse.' 'She''s dead, of course!' )
]

{ #category : 'tests' }
FoodChainTest >> test09_MultipleVerses [
	| result |

	result := foodChainCalculator reciteStartVerse: 1 endVerse: 3 .
	self assert: result equals: #('I know an old lady who swallowed a fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a spider.' 'It wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a bird.' 'How absurd to swallow a bird!' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' )
]

{ #category : 'tests' }
FoodChainTest >> test10_FullSong [
	| result |

	result := foodChainCalculator reciteStartVerse: 1 endVerse: 8 .
	self assert: result equals: #('I know an old lady who swallowed a fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a spider.' 'It wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a bird.' 'How absurd to swallow a bird!' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a cat.' 'Imagine that, to swallow a cat!' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a dog.' 'What a hog, to swallow a dog!' 'She swallowed the dog to catch the cat.' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a goat.' 'Just opened her throat and swallowed a goat!' 'She swallowed the goat to catch the dog.' 'She swallowed the dog to catch the cat.' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a cow.' 'I don''t know how she swallowed a cow!' 'She swallowed the cow to catch the goat.' 'She swallowed the goat to catch the dog.' 'She swallowed the dog to catch the cat.' 'She swallowed the cat to catch the bird.' 'She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.' 'She swallowed the spider to catch the fly.' 'I don''t know why she swallowed the fly. Perhaps she''ll die.' '' 'I know an old lady who swallowed a horse.' 'She''s dead, of course!' )
]
