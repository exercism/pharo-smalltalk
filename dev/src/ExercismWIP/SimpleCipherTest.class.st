"
# Simple Cipher

Implement a simple shift cipher like Caesar and a more secure substitution cipher.

## Step 1

""If he had anything confidential to say, he wrote it in cipher, that is,
by so changing the order of the letters of the alphabet, that not a word
could be made out. If anyone wishes to decipher these, and get at their
meaning, he must substitute the fourth letter of the alphabet, namely D,
for A, and so with the others.""
—Suetonius, Life of Julius Caesar

Ciphers are very straight-forward algorithms that allow us to render
text less readable while still allowing easy deciphering. They are
vulnerable to many forms of cryptanalysis, but we are lucky that
generally our little sisters are not cryptanalysts.

The Caesar Cipher was used for some messages from Julius Caesar that
were sent afield. Now Caesar knew that the cipher wasn't very good, but
he had one ally in that respect: almost nobody could read well. So even
being a couple letters off was sufficient so that people couldn't
recognize the few words that they did know.

Your task is to create a simple shift cipher like the Caesar Cipher.
This image is a great example of the Caesar Cipher:

![Caesar Cipher][1]

For example:

Giving ""iamapandabear"" as input to the encode function returns the cipher ""ldpdsdqgdehdu"". Obscure enough to keep our message secret in transit.

When ""ldpdsdqgdehdu"" is put into the decode function it would return
the original ""iamapandabear"" letting your friend read your original
message.

## Step 2

Shift ciphers are no fun though when your kid sister figures it out. Try
amending the code to allow us to specify a key and use that for the
shift distance. This is called a substitution cipher.

Here's an example:

Given the key ""aaaaaaaaaaaaaaaaaa"", encoding the string ""iamapandabear""
would return the original ""iamapandabear"".

Given the key ""ddddddddddddddddd"", encoding our string ""iamapandabear""
would return the obscured ""ldpdsdqgdehdu""

In the example above, we've set a = 0 for the key value. So when the
plaintext is added to the key, we end up with the same message coming
out. So ""aaaa"" is not an ideal key. But if we set the key to ""dddd"", we
would get the same thing as the Caesar Cipher.

## Step 3

The weakest link in any cipher is the human being. Let's make your
substitution cipher a little more fault tolerant by providing a source
of randomness and ensuring that the key contains only lowercase letters.

If someone doesn't submit a key at all, generate a truly random key of
at least 100 alphanumeric characters in length.

## Extensions

Shift ciphers work by making the text slightly odd, but are vulnerable
to frequency analysis. Substitution ciphers help that, but are still
very vulnerable when the key is short or if spaces are preserved. Later
on you'll see one solution to this problem in the exercise
""crypto-square"".

If you want to go farther in this field, the questions begin to be about
how we can exchange keys in a secure way. Take a look at [Diffie-Hellman
on Wikipedia][dh] for one of the first implementations of this scheme.

[1]: https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Caesar_cipher_left_shift_of_3.svg/320px-Caesar_cipher_left_shift_of_3.svg.png
[dh]: http://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange

## Hint

TBD

"
Class {
	#name : #SimpleCipherTest,
	#superclass : #ExercismTest,
	#instVars : [
		'simpleCipherCalculator'
	],
	#category : #'ExercismWIP-SimpleCipher'
}

{ #category : #config }
SimpleCipherTest class >> uuid [
	"Answer a unique id for this exercise"
	^'473ea6be-4a3f-0d00-bb71-1079071d6982'
]

{ #category : #config }
SimpleCipherTest class >> version [
	"Generated from specification: 28 February 2019"
	^'2.0.0'
]

{ #category : #setup }
SimpleCipherTest >> setUp [
	simpleCipherCalculator := SimpleCipher new
]

{ #category : #tests }
SimpleCipherTest >> test01_RandomKeyCipherCanEncode [
	| result |

	result := simpleCipherCalculator encodePlaintext: 'aaaaaaaaaa' .
	self assert: result equals: 'cipher.key.substring(0, plaintext.length)'
]

{ #category : #tests }
SimpleCipherTest >> test01_SubstitutionCipherCanEncode [
	| result |

	result := simpleCipherCalculator encodeKey: 'abcdefghij' plaintext: 'aaaaaaaaaa' .
	self assert: result equals: 'abcdefghij'
]

{ #category : #tests }
SimpleCipherTest >> test02_RandomKeyCipherCanDecode [
	| result |

	result := simpleCipherCalculator decodeCiphertext: 'cipher.key.substring(0, expected.length)' .
	self assert: result equals: 'aaaaaaaaaa'
]

{ #category : #tests }
SimpleCipherTest >> test02_SubstitutionCipherCanDecode [
	| result |

	result := simpleCipherCalculator decodeCiphertext: 'abcdefghij' key: 'abcdefghij' .
	self assert: result equals: 'aaaaaaaaaa'
]

{ #category : #tests }
SimpleCipherTest >> test03_RandomKeyCipherIsReversibleIeIfYouApplyDecodeInAEncodedResultYouMustSeeTheSamePlaintextEncodeParameterAsAResultOfTheDecodeMethod [
	| result |

	result := simpleCipherCalculator decodeCiphertext: 'cipher.encode' plaintext: 'abcdefghij' .
	self assert: result equals: 'abcdefghij'
]

{ #category : #tests }
SimpleCipherTest >> test03_SubstitutionCipherIsReversibleIeIfYouApplyDecodeInAEncodedResultYouMustSeeTheSamePlaintextEncodeParameterAsAResultOfTheDecodeMethod [
	| result |

	result := simpleCipherCalculator decodeCiphertext: 'cipher.encode' key: 'abcdefghij' plaintext: 'abcdefghij' .
	self assert: result equals: 'abcdefghij'
]

{ #category : #tests }
SimpleCipherTest >> test04_RandomKeyCipherKeyIsMadeOnlyOfLowercaseLetters [
	| result |

	result := simpleCipherCalculator key.
	self assert: result equals: ((Dictionary new) add: ('match'->'^[a-z]+$'); yourself)
]

{ #category : #tests }
SimpleCipherTest >> test04_SubstitutionCipherCanDoubleShiftEncode [
	| result |

	result := simpleCipherCalculator encodeKey: 'iamapandabear' plaintext: 'iamapandabear' .
	self assert: result equals: 'qayaeaagaciai'
]

{ #category : #tests }
SimpleCipherTest >> test05_SubstitutionCipherCanWrapOnEncode [
	| result |

	result := simpleCipherCalculator encodeKey: 'abcdefghij' plaintext: 'zzzzzzzzzz' .
	self assert: result equals: 'zabcdefghi'
]

{ #category : #tests }
SimpleCipherTest >> test06_SubstitutionCipherCanWrapOnDecode [
	| result |

	result := simpleCipherCalculator decodeCiphertext: 'zabcdefghi' key: 'abcdefghij' .
	self assert: result equals: 'zzzzzzzzzz'
]

{ #category : #tests }
SimpleCipherTest >> test07_SubstitutionCipherCanEncodeMessagesLongerThanTheKey [
	| result |

	result := simpleCipherCalculator encodeKey: 'abc' plaintext: 'iamapandabear' .
	self assert: result equals: 'iboaqcnecbfcr'
]

{ #category : #tests }
SimpleCipherTest >> test08_SubstitutionCipherCanDecodeMessagesLongerThanTheKey [
	| result |

	result := simpleCipherCalculator decodeCiphertext: 'iboaqcnecbfcr' key: 'abc' .
	self assert: result equals: 'iamapandabear'
]
