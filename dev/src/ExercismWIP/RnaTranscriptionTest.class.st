"
# Rna Transcription

Given a DNA strand, return its RNA complement (per RNA transcription).

Both DNA and RNA strands are a sequence of nucleotides.

The four nucleotides found in DNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and thymine (**T**).

The four nucleotides found in RNA are adenine (**A**), cytosine (**C**),
guanine (**G**) and uracil (**U**).

Given a DNA strand, its transcribed RNA strand is formed by replacing
each nucleotide with its complement:

* `G` -> `C`
* `C` -> `G`
* `T` -> `A`
* `A` -> `U`

## Hint

TBD

"
Class {
	#name : #RnaTranscriptionTest,
	#superclass : #ExercismTest,
	#instVars : [
		'rnaTranscriptionCalculator'
	],
	#category : #'ExercismWIP-RnaTranscription'
}

{ #category : #config }
RnaTranscriptionTest class >> uuid [
	"Answer a unique id for this exercise"
	^'6026e3d9-2b3f-0d00-a2bc-7b6709f0590c'
]

{ #category : #config }
RnaTranscriptionTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.3.0'
]

{ #category : #setup }
RnaTranscriptionTest >> setUp [
	rnaTranscriptionCalculator := RnaTranscription new
]

{ #category : #test }
RnaTranscriptionTest >> testEmptyRNASequence [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: '' .
	self assert: result equals: ''
]

{ #category : #test }
RnaTranscriptionTest >> testRNAComplement [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'ACGTGGTCTTAA' .
	self assert: result equals: 'UGCACCAGAAUU'
]

{ #category : #test }
RnaTranscriptionTest >> testRNAComplementOfAdenineIsUracil [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'A' .
	self assert: result equals: 'U'
]

{ #category : #test }
RnaTranscriptionTest >> testRNAComplementOfCytosineIsGuanine [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'C' .
	self assert: result equals: 'G'
]

{ #category : #test }
RnaTranscriptionTest >> testRNAComplementOfGuanineIsCytosine [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'G' .
	self assert: result equals: 'C'
]

{ #category : #test }
RnaTranscriptionTest >> testRNAComplementOfThymineIsAdenine [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'T' .
	self assert: result equals: 'A'
]
