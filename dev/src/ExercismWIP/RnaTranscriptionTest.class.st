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
	^'aee2ac16-9d41-0d00-8fce-202108866539'
]

{ #category : #config }
RnaTranscriptionTest class >> version [
	"Generated from specification: 29 March 2019"
	^'1.3.0'
]

{ #category : #setup }
RnaTranscriptionTest >> setUp [
	rnaTranscriptionCalculator := RnaTranscription new
]

{ #category : #tests }
RnaTranscriptionTest >> test01_EmptyRNASequence [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: '' .
	self assert: result equals: ''
]

{ #category : #tests }
RnaTranscriptionTest >> test02_RNAComplementOfCytosineIsGuanine [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'C' .
	self assert: result equals: 'G'
]

{ #category : #tests }
RnaTranscriptionTest >> test03_RNAComplementOfGuanineIsCytosine [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'G' .
	self assert: result equals: 'C'
]

{ #category : #tests }
RnaTranscriptionTest >> test04_RNAComplementOfThymineIsAdenine [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'T' .
	self assert: result equals: 'A'
]

{ #category : #tests }
RnaTranscriptionTest >> test05_RNAComplementOfAdenineIsUracil [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'A' .
	self assert: result equals: 'U'
]

{ #category : #tests }
RnaTranscriptionTest >> test06_RNAComplement [
	| result |

	result := rnaTranscriptionCalculator toRnaDna: 'ACGTGGTCTTAA' .
	self assert: result equals: 'UGCACCAGAAUU'
]
