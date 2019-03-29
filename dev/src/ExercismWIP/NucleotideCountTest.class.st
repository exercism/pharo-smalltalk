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
	^'e8a6bb16-9d41-0d00-8fda-45f308866539'
]

{ #category : #config }
NucleotideCountTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.3.0'
]

{ #category : #setup }
NucleotideCountTest >> setUp [
	nucleotideCountCalculator := NucleotideCount new
]

{ #category : #tests }
NucleotideCountTest >> test01_CountAllNucleotidesInAStrandEmptyStrand [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: '' .
	self assert: result equals: ((Dictionary new) add: ('G'->0); add: ('T'->0); add: ('A'->0); add: ('C'->0); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test02_CountAllNucleotidesInAStrandCanCountOneNucleotideInSinglecharacterInput [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: 'G' .
	self assert: result equals: ((Dictionary new) add: ('G'->1); add: ('T'->0); add: ('A'->0); add: ('C'->0); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test03_CountAllNucleotidesInAStrandStrandWithRepeatedNucleotide [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: 'GGGGGGG' .
	self assert: result equals: ((Dictionary new) add: ('G'->7); add: ('T'->0); add: ('A'->0); add: ('C'->0); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test04_CountAllNucleotidesInAStrandStrandWithMultipleNucleotides [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: 'AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC' .
	self assert: result equals: ((Dictionary new) add: ('G'->17); add: ('T'->21); add: ('A'->20); add: ('C'->12); yourself)
]

{ #category : #tests }
NucleotideCountTest >> test05_CountAllNucleotidesInAStrandStrandWithInvalidNucleotides [
	| result |

	result := nucleotideCountCalculator nucleotideCountsStrand: 'AGXXACT' .
	self assert: result equals: ((Dictionary new) add: ('error'->'Invalid nucleotide in strand'); yourself)
]
