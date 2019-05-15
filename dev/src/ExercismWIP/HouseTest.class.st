"
# House

Recite the nursery rhyme 'This is the House that Jack Built'.

> [The] process of placing a phrase of clause within another phrase of
> clause is called embedding. It is through the processes of recursion
> and embedding that we are able to take a finite number of forms (words
> and phrases) and construct an infinite number of expressions.
> Furthermore, embedding also allows us to construct an infinitely long
> structure, in theory anyway.

- [papyr.com](http://papyr.com/hypertextbooks/grammar/ph_noun.htm)

The nursery rhyme reads as follows:

```text
This is the house that Jack built.

This is the malt
that lay in the house that Jack built.

This is the rat
that ate the malt
that lay in the house that Jack built.

This is the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the farmer sowing his corn
that kept the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the horse and the hound and the horn
that belonged to the farmer sowing his corn
that kept the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.
```

## Hint

TBD

"
Class {
	#name : #HouseTest,
	#superclass : #ExercismTest,
	#instVars : [
		'houseCalculator'
	],
	#category : #'ExercismWIP-House'
}

{ #category : #config }
HouseTest class >> uuid [
	"Answer a unique id for this exercise"
	^'724ec42e-b043-0d00-9276-8eee02a76407'
]

{ #category : #config }
HouseTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.2.0'
]

{ #category : #running }
HouseTest >> setUp [
	super setUp.
	houseCalculator := House new
]

{ #category : #tests }
HouseTest >> test01_VerseOneTheHouseThatJackBuilt [
	| result |

	result := houseCalculator reciteStartVerse: 1 endVerse: 1 .
	self assert: result equals: #('This is the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test02_VerseTwoTheMaltThatLay [
	| result |

	result := houseCalculator reciteStartVerse: 2 endVerse: 2 .
	self assert: result equals: #('This is the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test03_VerseThreeTheRatThatAte [
	| result |

	result := houseCalculator reciteStartVerse: 3 endVerse: 3 .
	self assert: result equals: #('This is the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test04_VerseFourTheCatThatKilled [
	| result |

	result := houseCalculator reciteStartVerse: 4 endVerse: 4 .
	self assert: result equals: #('This is the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test05_VerseFiveTheDogThatWorried [
	| result |

	result := houseCalculator reciteStartVerse: 5 endVerse: 5 .
	self assert: result equals: #('This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test06_VerseSixTheCowWithTheCrumpledHorn [
	| result |

	result := houseCalculator reciteStartVerse: 6 endVerse: 6 .
	self assert: result equals: #('This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test07_VerseSevenTheMaidenAllForlorn [
	| result |

	result := houseCalculator reciteStartVerse: 7 endVerse: 7 .
	self assert: result equals: #('This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test08_VerseEightTheManAllTatteredAndTorn [
	| result |

	result := houseCalculator reciteStartVerse: 8 endVerse: 8 .
	self assert: result equals: #('This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test09_VerseNineThePriestAllShavenAndShorn [
	| result |

	result := houseCalculator reciteStartVerse: 9 endVerse: 9 .
	self assert: result equals: #('This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test10_Verse10TheRoosterThatCrowedInTheMorn [
	| result |

	result := houseCalculator reciteStartVerse: 10 endVerse: 10 .
	self assert: result equals: #('This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test11_Verse11TheFarmerSowingHisCorn [
	| result |

	result := houseCalculator reciteStartVerse: 11 endVerse: 11 .
	self assert: result equals: #('This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test12_Verse12TheHorseAndTheHoundAndTheHorn [
	| result |

	result := houseCalculator reciteStartVerse: 12 endVerse: 12 .
	self assert: result equals: #('This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test13_MultipleVerses [
	| result |

	result := houseCalculator reciteStartVerse: 4 endVerse: 8 .
	self assert: result equals: #('This is the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]

{ #category : #tests }
HouseTest >> test14_FullRhyme [
	| result |

	result := houseCalculator reciteStartVerse: 1 endVerse: 12 .
	self assert: result equals: #('This is the house that Jack built.' 'This is the malt that lay in the house that Jack built.' 'This is the rat that ate the malt that lay in the house that Jack built.' 'This is the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' 'This is the horse and the hound and the horn that belonged to the farmer sowing his corn that kept the rooster that crowed in the morn that woke the priest all shaven and shorn that married the man all tattered and torn that kissed the maiden all forlorn that milked the cow with the crumpled horn that tossed the dog that worried the cat that killed the rat that ate the malt that lay in the house that Jack built.' )
]
