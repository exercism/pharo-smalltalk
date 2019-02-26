"
# Grep

Search a file for lines matching a regular expression pattern. Return the line
number and contents of each matching line.

The Unix [`grep`](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html) command can be used to search for lines in one or more files
that match a user-provided search query (known as the *pattern*).

The `grep` command takes three arguments:

1. The pattern used to match lines in a file.
2. Zero or more flags to customize the matching behavior.
3. One or more files in which to search for matching lines.

Your task is to implement the `grep` function, which should read the contents
of the specified files, find the lines that match the specified pattern
and then output those lines as a single string. Note that the lines should
be output in the order in which they were found, with the first matching line
in the first file being output first.

As an example, suppose there is a file named ""input.txt"" with the following contents:

```text
hello
world
hello again
```

If we were to call `grep ""hello"" input.txt`, the returned string should be:

```text
hello
hello again
```

### Flags

As said earlier, the `grep` command should also support the following flags:

- `-n` Print the line numbers of each matching line.
- `-l` Print only the names of files that contain at least one matching line.
- `-i` Match line using a case-insensitive comparison.
- `-v` Invert the program -- collect all lines that fail to match the pattern.
- `-x` Only match entire lines, instead of lines that contain a match.

If we run `grep -n ""hello"" input.txt`, the `-n` flag will require the matching
lines to be prefixed with its line number:

```text
1:hello
3:hello again
```

And if we run `grep -i ""HELLO"" input.txt`, we'll do a case-insensitive match,
and the output will be:

```text
hello
hello again
```

The `grep` command should support multiple flags at once.

For example, running `grep -l -v ""hello"" file1.txt file2.txt` should
print the names of files that do not contain the string ""hello"".

## Hint

TBD

"
Class {
	#name : #GrepTest,
	#superclass : #ExercismTest,
	#instVars : [
		'grepCalculator'
	],
	#category : #'ExercismWIP-Grep'
}

{ #category : #config }
GrepTest class >> uuid [
	"Answer a unique id for this exercise"
	^'62430eda-2b3f-0d00-a2e6-ba1809f0590c'
]

{ #category : #config }
GrepTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.2.0'
]

{ #category : #setup }
GrepTest >> setUp [
	grepCalculator := Grep new
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileNoMatchesVariousFlags [
	| result |

	result := grepCalculator grepFlags: #('-n' '-l' '-x' '-i' ) pattern: 'Gandalf' files: #('iliad.txt' ) .
	self assert: result equals: #()
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileOneMatchCaseinsensitiveFlag [
	| result |

	result := grepCalculator grepFlags: #('-i' ) pattern: 'FORBIDDEN' files: #('paradise-lost.txt' ) .
	self assert: result equals: #('Of that Forbidden Tree, whose mortal tast' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileOneMatchFileFlagTakesPrecedenceOverLineFlag [
	| result |

	result := grepCalculator grepFlags: #('-n' '-l' ) pattern: 'ten' files: #('iliad.txt' ) .
	self assert: result equals: #('iliad.txt' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileOneMatchMatchEntireLinesFlag [
	| result |

	result := grepCalculator grepFlags: #('-x' ) pattern: 'With loss of Eden, till one greater Man' files: #('paradise-lost.txt' ) .
	self assert: result equals: #('With loss of Eden, till one greater Man' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileOneMatchMultipleFlags [
	| result |

	result := grepCalculator grepFlags: #('-n' '-i' '-x' ) pattern: 'OF ATREUS, Agamemnon, KIng of MEN.' files: #('iliad.txt' ) .
	self assert: result equals: #('9:Of Atreus, Agamemnon, King of men.' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileOneMatchNoFlags [
	| result |

	result := grepCalculator grepFlags: #() pattern: 'Agamemnon' files: #('iliad.txt' ) .
	self assert: result equals: #('Of Atreus, Agamemnon, King of men.' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileOneMatchPrintFileNamesFlag [
	| result |

	result := grepCalculator grepFlags: #('-l' ) pattern: 'Forbidden' files: #('paradise-lost.txt' ) .
	self assert: result equals: #('paradise-lost.txt' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileOneMatchPrintLineNumbersFlag [
	| result |

	result := grepCalculator grepFlags: #('-n' ) pattern: 'Forbidden' files: #('paradise-lost.txt' ) .
	self assert: result equals: #('2:Of that Forbidden Tree, whose mortal tast' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileSeveralMatchesCaseinsensitiveFlag [
	| result |

	result := grepCalculator grepFlags: #('-i' ) pattern: 'ACHILLES' files: #('iliad.txt' ) .
	self assert: result equals: #('Achilles sing, O Goddess! Peleus'' son;' 'The noble Chief Achilles from the son' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileSeveralMatchesInvertedAndMatchEntireLinesFlags [
	| result |

	result := grepCalculator grepFlags: #('-x' '-v' ) pattern: 'Illustrious into Ades premature,' files: #('iliad.txt' ) .
	self assert: result equals: #('Achilles sing, O Goddess! Peleus'' son;' 'His wrath pernicious, who ten thousand woes' 'Caused to Achaia''s host, sent many a soul' 'And Heroes gave (so stood the will of Jove)' 'To dogs and to all ravening fowls a prey,' 'When fierce dispute had separated once' 'The noble Chief Achilles from the son' 'Of Atreus, Agamemnon, King of men.' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileSeveralMatchesInvertedFlag [
	| result |

	result := grepCalculator grepFlags: #('-v' ) pattern: 'Of' files: #('paradise-lost.txt' ) .
	self assert: result equals: #('Brought Death into the World, and all our woe,' 'With loss of Eden, till one greater Man' 'Restore us, and regain the blissful Seat,' 'Sing Heav''nly Muse, that on the secret top' 'That Shepherd, who first taught the chosen Seed' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileSeveralMatchesMatchEntireLinesFlag [
	| result |

	result := grepCalculator grepFlags: #('-x' ) pattern: 'may' files: #('midsummer-night.txt' ) .
	self assert: result equals: #()
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileSeveralMatchesNoFlags [
	| result |

	result := grepCalculator grepFlags: #() pattern: 'may' files: #('midsummer-night.txt' ) .
	self assert: result equals: #('Nor how it may concern my modesty,' 'But I beseech your grace that I may know' 'The worst that may befall me in this case,' )
]

{ #category : #test }
GrepTest >> testTestGreppingASingleFileOneFileSeveralMatchesPrintLineNumbersFlag [
	| result |

	result := grepCalculator grepFlags: #('-n' ) pattern: 'may' files: #('midsummer-night.txt' ) .
	self assert: result equals: #('3:Nor how it may concern my modesty,' '5:But I beseech your grace that I may know' '6:The worst that may befall me in this case,' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesNoMatchesVariousFlags [
	| result |

	result := grepCalculator grepFlags: #('-n' '-l' '-x' '-i' ) pattern: 'Frodo' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #()
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesOneMatchMatchEntireLinesFlag [
	| result |

	result := grepCalculator grepFlags: #('-x' ) pattern: 'But I beseech your grace that I may know' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('midsummer-night.txt:But I beseech your grace that I may know' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesOneMatchMultipleFlags [
	| result |

	result := grepCalculator grepFlags: #('-n' '-i' '-x' ) pattern: 'WITH LOSS OF EDEN, TILL ONE GREATER MAN' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('paradise-lost.txt:4:With loss of Eden, till one greater Man' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesOneMatchNoFlags [
	| result |

	result := grepCalculator grepFlags: #() pattern: 'Agamemnon' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('iliad.txt:Of Atreus, Agamemnon, King of men.' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesOneMatchPrintFileNamesFlag [
	| result |

	result := grepCalculator grepFlags: #('-l' ) pattern: 'who' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('iliad.txt' 'paradise-lost.txt' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesSeveralMatchesCaseinsensitiveFlag [
	| result |

	result := grepCalculator grepFlags: #('-i' ) pattern: 'TO' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('iliad.txt:Caused to Achaia''s host, sent many a soul' 'iliad.txt:Illustrious into Ades premature,' 'iliad.txt:And Heroes gave (so stood the will of Jove)' 'iliad.txt:To dogs and to all ravening fowls a prey,' 'midsummer-night.txt:I do entreat your grace to pardon me.' 'midsummer-night.txt:In such a presence here to plead my thoughts;' 'midsummer-night.txt:If I refuse to wed Demetrius.' 'paradise-lost.txt:Brought Death into the World, and all our woe,' 'paradise-lost.txt:Restore us, and regain the blissful Seat,' 'paradise-lost.txt:Sing Heav''nly Muse, that on the secret top' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesSeveralMatchesFileFlagTakesPrecedenceOverLineNumberFlag [
	| result |

	result := grepCalculator grepFlags: #('-n' '-l' ) pattern: 'who' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('iliad.txt' 'paradise-lost.txt' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesSeveralMatchesInvertedAndMatchEntireLinesFlags [
	| result |

	result := grepCalculator grepFlags: #('-x' '-v' ) pattern: 'Illustrious into Ades premature,' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('iliad.txt:Achilles sing, O Goddess! Peleus'' son;' 'iliad.txt:His wrath pernicious, who ten thousand woes' 'iliad.txt:Caused to Achaia''s host, sent many a soul' 'iliad.txt:And Heroes gave (so stood the will of Jove)' 'iliad.txt:To dogs and to all ravening fowls a prey,' 'iliad.txt:When fierce dispute had separated once' 'iliad.txt:The noble Chief Achilles from the son' 'iliad.txt:Of Atreus, Agamemnon, King of men.' 'midsummer-night.txt:I do entreat your grace to pardon me.' 'midsummer-night.txt:I know not by what power I am made bold,' 'midsummer-night.txt:Nor how it may concern my modesty,' 'midsummer-night.txt:In such a presence here to plead my thoughts;' 'midsummer-night.txt:But I beseech your grace that I may know' 'midsummer-night.txt:The worst that may befall me in this case,' 'midsummer-night.txt:If I refuse to wed Demetrius.' 'paradise-lost.txt:Of Mans First Disobedience, and the Fruit' 'paradise-lost.txt:Of that Forbidden Tree, whose mortal tast' 'paradise-lost.txt:Brought Death into the World, and all our woe,' 'paradise-lost.txt:With loss of Eden, till one greater Man' 'paradise-lost.txt:Restore us, and regain the blissful Seat,' 'paradise-lost.txt:Sing Heav''nly Muse, that on the secret top' 'paradise-lost.txt:Of Oreb, or of Sinai, didst inspire' 'paradise-lost.txt:That Shepherd, who first taught the chosen Seed' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesSeveralMatchesInvertedFlag [
	| result |

	result := grepCalculator grepFlags: #('-v' ) pattern: 'a' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('iliad.txt:Achilles sing, O Goddess! Peleus'' son;' 'iliad.txt:The noble Chief Achilles from the son' 'midsummer-night.txt:If I refuse to wed Demetrius.' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesSeveralMatchesNoFlags [
	| result |

	result := grepCalculator grepFlags: #() pattern: 'may' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('midsummer-night.txt:Nor how it may concern my modesty,' 'midsummer-night.txt:But I beseech your grace that I may know' 'midsummer-night.txt:The worst that may befall me in this case,' )
]

{ #category : #test }
GrepTest >> testTestGreppingMultiplesFilesAtOnceMultipleFilesSeveralMatchesPrintLineNumbersFlag [
	| result |

	result := grepCalculator grepFlags: #('-n' ) pattern: 'that' files: #('iliad.txt' 'midsummer-night.txt' 'paradise-lost.txt' ) .
	self assert: result equals: #('midsummer-night.txt:5:But I beseech your grace that I may know' 'midsummer-night.txt:6:The worst that may befall me in this case,' 'paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast' 'paradise-lost.txt:6:Sing Heav''nly Muse, that on the secret top' )
]
