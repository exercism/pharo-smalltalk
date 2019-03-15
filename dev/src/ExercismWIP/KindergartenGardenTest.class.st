"
# Kindergarten Garden

Given a diagram, determine which plants each child in the kindergarten class is
responsible for.

The kindergarten class is learning about growing plants. The teacher
thought it would be a good idea to give them actual seeds, plant them in
actual dirt, and grow actual plants.

They've chosen to grow grass, clover, radishes, and violets.

To this end, the children have put little cups along the window sills, and
planted one type of plant in each cup, choosing randomly from the available
types of seeds.

```text
[window][window][window]
........................ # each dot represents a cup
........................
```

There are 12 children in the class:

- Alice, Bob, Charlie, David,
- Eve, Fred, Ginny, Harriet,
- Ileana, Joseph, Kincaid, and Larry.

Each child gets 4 cups, two on each row. Their teacher assigns cups to
the children alphabetically by their names.

The following diagram represents Alice's plants:

```text
[window][window][window]
VR......................
RG......................
```

In the first row, nearest the windows, she has a violet and a radish.  In the
second row she has a radish and some grass.

Your program will be given the plants from left-to-right starting with
the row nearest the windows. From this, it should be able to determine
which plants belong to each student.

For example, if it's told that the garden looks like so:

```text
[window][window][window]
VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV
```

Then if asked for Alice's plants, it should provide:

- Violets, radishes, violets, radishes

While asking for Bob's plants would yield:

- Clover, grass, clover, clover

## Hint

TBD

"
Class {
	#name : #KindergartenGardenTest,
	#superclass : #ExercismTest,
	#instVars : [
		'kindergartenGardenCalculator'
	],
	#category : #'ExercismWIP-KindergartenGarden'
}

{ #category : #config }
KindergartenGardenTest class >> uuid [
	"Answer a unique id for this exercise"
	^'9598e3bb-8040-0d00-812c-7d2101deb008'
]

{ #category : #config }
KindergartenGardenTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.1.1'
]

{ #category : #setup }
KindergartenGardenTest >> setUp [
	kindergartenGardenCalculator := KindergartenGarden new
]

{ #category : #tests }
KindergartenGardenTest >> test01_FullGardenFirstStudentsGarden [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Alice' diagram: 'VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV' .
	self assert: result equals: #('violets' 'radishes' 'violets' 'radishes' )
]

{ #category : #tests }
KindergartenGardenTest >> test01_PartialGardenGardenWithSingleStudent [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Alice' diagram: 'RC
GG' .
	self assert: result equals: #('radishes' 'clover' 'grass' 'grass' )
]

{ #category : #tests }
KindergartenGardenTest >> test01_PartialGardenMultipleStudentsForTheSameGardenWithThreeStudentsSecondStudentsGarden [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Bob' diagram: 'VVCCGG
VVCCGG' .
	self assert: result equals: #('clover' 'clover' 'clover' 'clover' )
]

{ #category : #tests }
KindergartenGardenTest >> test02_FullGardenSecondStudentsGarden [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Bob' diagram: 'VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV' .
	self assert: result equals: #('clover' 'grass' 'clover' 'clover' )
]

{ #category : #tests }
KindergartenGardenTest >> test02_PartialGardenDifferentGardenWithSingleStudent [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Alice' diagram: 'VC
RC' .
	self assert: result equals: #('violets' 'clover' 'radishes' 'clover' )
]

{ #category : #tests }
KindergartenGardenTest >> test02_PartialGardenMultipleStudentsForTheSameGardenWithThreeStudentsThirdStudentsGarden [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Charlie' diagram: 'VVCCGG
VVCCGG' .
	self assert: result equals: #('grass' 'grass' 'grass' 'grass' )
]

{ #category : #tests }
KindergartenGardenTest >> test03_FullGardenSecondToLastStudentsGarden [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Kincaid' diagram: 'VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV' .
	self assert: result equals: #('grass' 'clover' 'clover' 'grass' )
]

{ #category : #tests }
KindergartenGardenTest >> test03_PartialGardenGardenWithTwoStudents [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Bob' diagram: 'VVCG
VVRC' .
	self assert: result equals: #('clover' 'grass' 'radishes' 'clover' )
]

{ #category : #tests }
KindergartenGardenTest >> test04_FullGardenLastStudentsGarden [
	| result |

	result := kindergartenGardenCalculator plantsStudent: 'Larry' diagram: 'VRCGVVRVCGGCCGVRGCVCGCGV
VRCCCGCRRGVCGCRVVCVGCGCV' .
	self assert: result equals: #('grass' 'violets' 'clover' 'violets' )
]
