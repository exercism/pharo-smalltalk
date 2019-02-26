"
# Protein Translation

Translate RNA sequences into proteins.

RNA can be broken into three nucleotide sequences called codons, and then translated to a polypeptide like so:

RNA: `""AUGUUUUCU""` => translates to

Codons: `""AUG"", ""UUU"", ""UCU""`
=> which become a polypeptide with the following sequence =>

Protein: `""Methionine"", ""Phenylalanine"", ""Serine""`

There are 64 codons which in turn correspond to 20 amino acids; however, all of the codon sequences and resulting amino acids are not important in this exercise.  If it works for one codon, the program should work for all of them.
However, feel free to expand the list in the test suite to include them all.

There are also three terminating codons (also known as 'STOP' codons); if any of these codons are encountered (by the ribosome), all translation ends and the protein is terminated.

All subsequent codons after are ignored, like this:

RNA: `""AUGUUUUCUUAAAUG""` =>

Codons: `""AUG"", ""UUU"", ""UCU"", ""UAA"", ""AUG""` =>

Protein: `""Methionine"", ""Phenylalanine"", ""Serine""`

Note the stop codon `""UAA""` terminates the translation and the final methionine is not translated into the protein sequence.

Below are the codons and resulting Amino Acids needed for the exercise.

Codon                 | Protein
:---                  | :---
AUG                   | Methionine
UUU, UUC              | Phenylalanine
UUA, UUG              | Leucine
UCU, UCC, UCA, UCG    | Serine
UAU, UAC              | Tyrosine
UGU, UGC              | Cysteine
UGG                   | Tryptophan
UAA, UAG, UGA         | STOP

Learn more about [protein translation on Wikipedia](http://en.wikipedia.org/wiki/Translation_(biology))

## Hint

TBD

"
Class {
	#name : #ProteinTranslationTest,
	#superclass : #ExercismTest,
	#instVars : [
		'proteinTranslationCalculator'
	],
	#category : #'ExercismWIP-ProteinTranslation'
}

{ #category : #config }
ProteinTranslationTest class >> uuid [
	"Answer a unique id for this exercise"
	^'c3c6d6d9-2b3f-0d00-a2ae-8bd009f0590c'
]

{ #category : #config }
ProteinTranslationTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.1'
]

{ #category : #setup }
ProteinTranslationTest >> setUp [
	proteinTranslationCalculator := ProteinTranslation new
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsCysteineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGU' .
	self assert: result equals: #('Cysteine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsCysteineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGC' .
	self assert: result equals: #('Cysteine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsLeucineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUA' .
	self assert: result equals: #('Leucine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsLeucineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUG' .
	self assert: result equals: #('Leucine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsMethionineRNASequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'AUG' .
	self assert: result equals: #('Methionine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsPhenylalanineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUU' .
	self assert: result equals: #('Phenylalanine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsPhenylalanineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUC' .
	self assert: result equals: #('Phenylalanine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsSTOPCodonRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAA' .
	self assert: result equals: #()
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsSTOPCodonRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAG' .
	self assert: result equals: #()
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsSTOPCodonRNASequence3 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGA' .
	self assert: result equals: #()
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsSerineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCU' .
	self assert: result equals: #('Serine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsSerineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCC' .
	self assert: result equals: #('Serine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsSerineRNASequence3 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCA' .
	self assert: result equals: #('Serine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsSerineRNASequence4 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCG' .
	self assert: result equals: #('Serine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTranslateRNAStrandIntoCorrectProteinList [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'AUGUUUUGG' .
	self assert: result equals: #('Methionine' 'Phenylalanine' 'Tryptophan' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonAtBeginningOfSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAGUGG' .
	self assert: result equals: #()
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonAtEndOfThreecodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'AUGUUUUAA' .
	self assert: result equals: #('Methionine' 'Phenylalanine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonAtEndOfTwocodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGGUAG' .
	self assert: result equals: #('Tryptophan' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonInMiddleOfSixcodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGGUGUUAUUAAUGGUUU' .
	self assert: result equals: #('Tryptophan' 'Cysteine' 'Tyrosine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonInMiddleOfThreecodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGGUAGUGG' .
	self assert: result equals: #('Tryptophan' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTryptophanRNASequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGG' .
	self assert: result equals: #('Tryptophan' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTyrosineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAU' .
	self assert: result equals: #('Tyrosine' )
]

{ #category : #test }
ProteinTranslationTest >> testTranslateInputRNASequencesIntoProteinsTyrosineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAC' .
	self assert: result equals: #('Tyrosine' )
]
