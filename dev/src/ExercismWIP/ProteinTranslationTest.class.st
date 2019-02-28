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
	^'961220be-4a3f-0d00-bb12-536b071d6982'
]

{ #category : #config }
ProteinTranslationTest class >> version [
	"Generated from specification: 28 February 2019"
	^'1.1.1'
]

{ #category : #setup }
ProteinTranslationTest >> setUp [
	proteinTranslationCalculator := ProteinTranslation new
]

{ #category : #tests }
ProteinTranslationTest >> test01_TranslateInputRNASequencesIntoProteinsMethionineRNASequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'AUG' .
	self assert: result equals: #('Methionine' )
]

{ #category : #tests }
ProteinTranslationTest >> test02_TranslateInputRNASequencesIntoProteinsPhenylalanineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUU' .
	self assert: result equals: #('Phenylalanine' )
]

{ #category : #tests }
ProteinTranslationTest >> test03_TranslateInputRNASequencesIntoProteinsPhenylalanineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUC' .
	self assert: result equals: #('Phenylalanine' )
]

{ #category : #tests }
ProteinTranslationTest >> test04_TranslateInputRNASequencesIntoProteinsLeucineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUA' .
	self assert: result equals: #('Leucine' )
]

{ #category : #tests }
ProteinTranslationTest >> test05_TranslateInputRNASequencesIntoProteinsLeucineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UUG' .
	self assert: result equals: #('Leucine' )
]

{ #category : #tests }
ProteinTranslationTest >> test06_TranslateInputRNASequencesIntoProteinsSerineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCU' .
	self assert: result equals: #('Serine' )
]

{ #category : #tests }
ProteinTranslationTest >> test07_TranslateInputRNASequencesIntoProteinsSerineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCC' .
	self assert: result equals: #('Serine' )
]

{ #category : #tests }
ProteinTranslationTest >> test08_TranslateInputRNASequencesIntoProteinsSerineRNASequence3 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCA' .
	self assert: result equals: #('Serine' )
]

{ #category : #tests }
ProteinTranslationTest >> test09_TranslateInputRNASequencesIntoProteinsSerineRNASequence4 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UCG' .
	self assert: result equals: #('Serine' )
]

{ #category : #tests }
ProteinTranslationTest >> test10_TranslateInputRNASequencesIntoProteinsTyrosineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAU' .
	self assert: result equals: #('Tyrosine' )
]

{ #category : #tests }
ProteinTranslationTest >> test11_TranslateInputRNASequencesIntoProteinsTyrosineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAC' .
	self assert: result equals: #('Tyrosine' )
]

{ #category : #tests }
ProteinTranslationTest >> test12_TranslateInputRNASequencesIntoProteinsCysteineRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGU' .
	self assert: result equals: #('Cysteine' )
]

{ #category : #tests }
ProteinTranslationTest >> test13_TranslateInputRNASequencesIntoProteinsCysteineRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGC' .
	self assert: result equals: #('Cysteine' )
]

{ #category : #tests }
ProteinTranslationTest >> test14_TranslateInputRNASequencesIntoProteinsTryptophanRNASequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGG' .
	self assert: result equals: #('Tryptophan' )
]

{ #category : #tests }
ProteinTranslationTest >> test15_TranslateInputRNASequencesIntoProteinsSTOPCodonRNASequence1 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAA' .
	self assert: result equals: #()
]

{ #category : #tests }
ProteinTranslationTest >> test16_TranslateInputRNASequencesIntoProteinsSTOPCodonRNASequence2 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAG' .
	self assert: result equals: #()
]

{ #category : #tests }
ProteinTranslationTest >> test17_TranslateInputRNASequencesIntoProteinsSTOPCodonRNASequence3 [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGA' .
	self assert: result equals: #()
]

{ #category : #tests }
ProteinTranslationTest >> test18_TranslateInputRNASequencesIntoProteinsTranslateRNAStrandIntoCorrectProteinList [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'AUGUUUUGG' .
	self assert: result equals: #('Methionine' 'Phenylalanine' 'Tryptophan' )
]

{ #category : #tests }
ProteinTranslationTest >> test19_TranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonAtBeginningOfSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UAGUGG' .
	self assert: result equals: #()
]

{ #category : #tests }
ProteinTranslationTest >> test20_TranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonAtEndOfTwocodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGGUAG' .
	self assert: result equals: #('Tryptophan' )
]

{ #category : #tests }
ProteinTranslationTest >> test21_TranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonAtEndOfThreecodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'AUGUUUUAA' .
	self assert: result equals: #('Methionine' 'Phenylalanine' )
]

{ #category : #tests }
ProteinTranslationTest >> test22_TranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonInMiddleOfThreecodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGGUAGUGG' .
	self assert: result equals: #('Tryptophan' )
]

{ #category : #tests }
ProteinTranslationTest >> test23_TranslateInputRNASequencesIntoProteinsTranslationStopsIfSTOPCodonInMiddleOfSixcodonSequence [
	| result |

	result := proteinTranslationCalculator proteinsStrand: 'UGGUGUUAUUAAUGGUUU' .
	self assert: result equals: #('Tryptophan' 'Cysteine' 'Tyrosine' )
]
