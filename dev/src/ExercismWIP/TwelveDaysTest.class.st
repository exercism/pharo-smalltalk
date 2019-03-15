"
# Twelve Days

Output the lyrics to 'The Twelve Days of Christmas'.

```text
On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.

On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.

On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.

On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.
```

## Hint

TBD

"
Class {
	#name : #TwelveDaysTest,
	#superclass : #ExercismTest,
	#instVars : [
		'twelveDaysCalculator'
	],
	#category : #'ExercismWIP-TwelveDays'
}

{ #category : #config }
TwelveDaysTest class >> uuid [
	"Answer a unique id for this exercise"
	^'6665d3bb-8040-0d00-811a-722c01deb008'
]

{ #category : #config }
TwelveDaysTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.2.0'
]

{ #category : #setup }
TwelveDaysTest >> setUp [
	twelveDaysCalculator := TwelveDays new
]

{ #category : #tests }
TwelveDaysTest >> test01_LyricsRecitesFirstThreeVersesOfTheSong [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 1 endVerse: 3 .
	self assert: result equals: #('On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.' 'On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.' 'On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test01_VerseFirstDayAPartridgeInAPearTree [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 1 endVerse: 1 .
	self assert: result equals: #('On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test02_LyricsRecitesThreeVersesFromTheMiddleOfTheSong [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 4 endVerse: 6 .
	self assert: result equals: #('On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test02_VerseSecondDayTwoTurtleDoves [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 2 endVerse: 2 .
	self assert: result equals: #('On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test03_LyricsRecitesTheWholeSong [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 1 endVerse: 12 .
	self assert: result equals: #('On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree.' 'On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree.' 'On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' 'On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test03_VerseThirdDayThreeFrenchHens [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 3 endVerse: 3 .
	self assert: result equals: #('On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test04_VerseFourthDayFourCallingBirds [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 4 endVerse: 4 .
	self assert: result equals: #('On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test05_VerseFifthDayFiveGoldRings [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 5 endVerse: 5 .
	self assert: result equals: #('On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test06_VerseSixthDaySixGeesealaying [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 6 endVerse: 6 .
	self assert: result equals: #('On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test07_VerseSeventhDaySevenSwansaswimming [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 7 endVerse: 7 .
	self assert: result equals: #('On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test08_VerseEighthDayEightMaidsamilking [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 8 endVerse: 8 .
	self assert: result equals: #('On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test09_VerseNinthDayNineLadiesDancing [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 9 endVerse: 9 .
	self assert: result equals: #('On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test10_VerseTenthDayTenLordsaleaping [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 10 endVerse: 10 .
	self assert: result equals: #('On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test11_VerseEleventhDayElevenPipersPiping [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 11 endVerse: 11 .
	self assert: result equals: #('On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]

{ #category : #tests }
TwelveDaysTest >> test12_VerseTwelfthDayTwelveDrummersDrumming [
	| result |

	result := twelveDaysCalculator reciteStartVerse: 12 endVerse: 12 .
	self assert: result equals: #('On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree.' )
]
