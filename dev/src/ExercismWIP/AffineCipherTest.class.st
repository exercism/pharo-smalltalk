"
# Affine Cipher

Create an implementation of the affine cipher,
an ancient encryption system created in the Middle East.
 
The affine cipher is a type of monoalphabetic substitution cipher.
Each character is mapped to its numeric equivalent, encrypted with
a mathematical function and then converted to the letter relating to
its new numeric value. Although all monoalphabetic ciphers are weak,
the affine cypher is much stronger than the atbash cipher,
because it has many more keys.
 
the encryption function is:
 
  `E(x) = (ax + b) mod m`
  -  where `x` is the letter's index from 0 - length of alphabet - 1
  -  `m` is the length of the alphabet. For the roman alphabet `m == 26`.
  -  and `a` and `b` make the key
 
the decryption function is:
 
  `D(y) = a^-1(y - b) mod m`
  -  where `y` is the numeric value of an encrypted letter, ie. `y = E(x)`
  -  it is important to note that `a^-1` is the modular multiplicative inverse
     of `a mod m`
  -  the modular multiplicative inverse of `a` only exists if `a` and `m` are
     coprime.
 
To find the MMI of `a`:

  `an mod m = 1`
  -  where `n` is the modular multiplicative inverse of `a mod m`

More information regarding how to find a Modular Multiplicative Inverse
and what it means can be found [here.](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse) 

Because automatic decryption fails if `a` is not coprime to `m` your
program should return status 1 and `""Error: a and m must be coprime.""`
if they are not.  Otherwise it should encode or decode with the
provided key.
 
The Caesar (shift) cipher is a simple affine cipher where `a` is 1 and
`b` as the magnitude results in a static displacement of the letters.
This is much less secure than a full implementation of the affine cipher.

Ciphertext is written out in groups of fixed length, the traditional group
size being 5 letters, and punctuation is excluded. This is to make it
harder to guess things based on word boundaries.

## Examples
 
 - Encoding `test` gives `ybty` with the key a=5 b=7
 - Decoding `ybty` gives `test` with the key a=5 b=7
 - Decoding `ybty` gives `lqul` with the wrong key a=11 b=7
 - Decoding `kqlfd jzvgy tpaet icdhm rtwly kqlon ubstx`
   - gives `thequickbrownfoxjumpsoverthelazydog` with the key a=19 b=13
 - Encoding `test` with the key a=18 b=13
   - gives `Error: a and m must be coprime.`
   - because a and m are not relatively prime

### Examples of finding a Modular Multiplicative Inverse (MMI)

  - simple example:
    - `9 mod 26 = 9`
    - `9 * 3 mod 26 = 27 mod 26 = 1`
    - `3` is the MMI of `9 mod 26`
  - a more complicated example:
    - `15 mod 26 = 15`
    - `15 * 7 mod 26 = 105 mod 26 = 1`
    - `7` is the MMI of `15 mod 26`

## Hint

TBD

"
Class {
	#name : #AffineCipherTest,
	#superclass : #ExercismTest,
	#instVars : [
		'affineCipherCalculator'
	],
	#category : #'ExercismWIP-AffineCipher'
}

{ #category : #config }
AffineCipherTest class >> uuid [
	"Answer a unique id for this exercise"
	^'1a14ab2e-b043-0d00-9251-dd7702a76407'
]

{ #category : #config }
AffineCipherTest class >> version [
	"Generated from specification: 25 April 2019"
	^'2.0.0'
]

{ #category : #setup }
AffineCipherTest >> setUp [
	affineCipherCalculator := AffineCipher new
]

{ #category : #tests }
AffineCipherTest >> test01_EncodeEncodeYes [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->5); add: ('b'->7); yourself) phrase: 'yes' .
	self assert: result equals: 'xbt'
]

{ #category : #tests }
AffineCipherTest >> test02_EncodeEncodeNo [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->15); add: ('b'->18); yourself) phrase: 'no' .
	self assert: result equals: 'fu'
]

{ #category : #tests }
AffineCipherTest >> test03_EncodeEncodeOMG [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->21); add: ('b'->3); yourself) phrase: 'OMG' .
	self assert: result equals: 'lvz'
]

{ #category : #tests }
AffineCipherTest >> test04_EncodeEncodeOMG [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->25); add: ('b'->47); yourself) phrase: 'O M G' .
	self assert: result equals: 'hjp'
]

{ #category : #tests }
AffineCipherTest >> test05_EncodeEncodeMindblowingly [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->11); add: ('b'->15); yourself) phrase: 'mindblowingly' .
	self assert: result equals: 'rzcwa gnxzc dgt'
]

{ #category : #tests }
AffineCipherTest >> test06_EncodeEncodeNumbers [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->3); add: ('b'->4); yourself) phrase: 'Testing,1 2 3, testing.' .
	self assert: result equals: 'jqgjc rw123 jqgjc rw'
]

{ #category : #tests }
AffineCipherTest >> test07_EncodeEncodeDeepThought [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->5); add: ('b'->17); yourself) phrase: 'Truth is fiction.' .
	self assert: result equals: 'iynia fdqfb ifje'
]

{ #category : #tests }
AffineCipherTest >> test08_EncodeEncodeAllTheLetters [
	| result |

	result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->17); add: ('b'->33); yourself) phrase: 'The quick brown fox jumps over the lazy dog.' .
	self assert: result equals: 'swxtj npvyk lruol iejdc blaxk swxmh qzglf'
]

{ #category : #tests }
AffineCipherTest >> test09_EncodeEncodeWithANotCoprimeToM [
	| result |

	self
		should: [ result := affineCipherCalculator encodeKey: ((Dictionary new) add: ('a'->6); add: ('b'->17); yourself) phrase: 'This is a test.' ]
		raise: Error
		whoseDescriptionIncludes: 'a and m must be coprime.'
		description: 'Should get an error with the correct description'
]

{ #category : #tests }
AffineCipherTest >> test10_DecodeDecodeExercism [
	| result |

	result := affineCipherCalculator decodeKey: ((Dictionary new) add: ('a'->3); add: ('b'->7); yourself) phrase: 'tytgn fjr' .
	self assert: result equals: 'exercism'
]

{ #category : #tests }
AffineCipherTest >> test11_DecodeDecodeASentence [
	| result |

	result := affineCipherCalculator decodeKey: ((Dictionary new) add: ('a'->19); add: ('b'->16); yourself) phrase: 'qdwju nqcro muwhn odqun oppmd aunwd o' .
	self assert: result equals: 'anobstacleisoftenasteppingstone'
]

{ #category : #tests }
AffineCipherTest >> test12_DecodeDecodeNumbers [
	| result |

	result := affineCipherCalculator decodeKey: ((Dictionary new) add: ('a'->25); add: ('b'->7); yourself) phrase: 'odpoz ub123 odpoz ub' .
	self assert: result equals: 'testing123testing'
]

{ #category : #tests }
AffineCipherTest >> test13_DecodeDecodeAllTheLetters [
	| result |

	result := affineCipherCalculator decodeKey: ((Dictionary new) add: ('a'->17); add: ('b'->33); yourself) phrase: 'swxtj npvyk lruol iejdc blaxk swxmh qzglf' .
	self assert: result equals: 'thequickbrownfoxjumpsoverthelazydog'
]

{ #category : #tests }
AffineCipherTest >> test14_DecodeDecodeWithNoSpacesInInput [
	| result |

	result := affineCipherCalculator decodeKey: ((Dictionary new) add: ('a'->17); add: ('b'->33); yourself) phrase: 'swxtjnpvyklruoliejdcblaxkswxmhqzglf' .
	self assert: result equals: 'thequickbrownfoxjumpsoverthelazydog'
]

{ #category : #tests }
AffineCipherTest >> test15_DecodeDecodeWithTooManySpaces [
	| result |

	result := affineCipherCalculator decodeKey: ((Dictionary new) add: ('a'->15); add: ('b'->16); yourself) phrase: 'vszzm    cly   yd cg    qdp' .
	self assert: result equals: 'jollygreengiant'
]

{ #category : #tests }
AffineCipherTest >> test16_DecodeDecodeWithANotCoprimeToM [
	| result |

	self
		should: [ result := affineCipherCalculator decodeKey: ((Dictionary new) add: ('a'->13); add: ('b'->5); yourself) phrase: 'Test' ]
		raise: Error
		whoseDescriptionIncludes: 'a and m must be coprime.'
		description: 'Should get an error with the correct description'
]
