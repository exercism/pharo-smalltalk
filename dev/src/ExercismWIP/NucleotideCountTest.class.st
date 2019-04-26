"
# Nucleotide Count

Given a single stranded DNA string, compute how many times each nucleotide occurs in the string.

The genetic language of every living thing on the planet is DNA.
DNA is a large molecule that is built from an extremely long sequence of individual elements called nucleotides.
4 types exist in DNA and these differ only slightly and can be represented as the following symbols: 'A' for adenine, 'C' for cytosine, 'G' for guanine, and 'T' thymine.

Here is an analogy:
- twigs are to birds nests as
- nucleotides are to DNA as
- legos are to lego houses as
- words are to sentences as...

## Hint

TBD

"
Class {
	#name : #NucleotideCountTest,
	#superclass : #ExercismTest,
	#instVars : [
		'nucleotideCountCalculator'
	],
	#category : #'ExercismWIP-NucleotideCount'
}

{ #category : #config }
NucleotideCountTest class >> uuid [
	"Answer a unique id for this exercise"
	^'4a33ae2e-b043-0d00-9256-8c7102a76407'
]

{ #category : #config }
NucleotideCountTest class >> version [
	"Generated from specification: 25 April 2019"
	^'1.3.0'
]

{ #category : #setup }
NucleotideCountTest >> setUp [
	nucleotideCountCalculator := NucleotideCount new
]

{ #category : #tests }
NucleotideCountTest >> test01_EmptyStrand [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: '' .
	self assert: result equals: ((Dictionary new) add: ('G'->0); add: ('T'->0); add: ('A'->0); add: ('C'->0); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test02_CanCountOneNucleotideInSinglecharacterInput [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: 'G' .
	self assert: result equals: ((Dictionary new) add: ('G'->1); add: ('T'->0); add: ('A'->0); add: ('C'->0); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test03_StrandWithRepeatedNucleotide [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: 'GGGGGGG' .
	self assert: result equals: ((Dictionary new) add: ('G'->7); add: ('T'->0); add: ('A'->0); add: ('C'->0); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test04_StrandWithMultipleNucleotides [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC' .
	self assert: result equals: ((Dictionary new) add: ('G'->17); add: ('T'->21); add: ('A'->20); add: ('C'->12); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test05_StrandWithInvalidNucleotides [
	| result |

	self
		should: [ result := nucleotideCountCalculator nucleotideCountsStrand: 'AGXXACT' ]
		raise: Error
		whoseDescriptionIncludes: 'Invalid nucleotide in strand'
		description: 'Should get an error with the correct description'
]
