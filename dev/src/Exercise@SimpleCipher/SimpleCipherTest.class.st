"
# SimpleCipher

# Description

Implement a simple shift cipher like Caesar and a more secure substitution cipher.

## Step 1

""If he had anything confidential to say, he wrote it in cipher, that is, by so changing the order of the letters of the alphabet, that not a word could be made out.
If anyone wishes to decipher these, and get at their meaning, he must substitute the fourth letter of the alphabet, namely D, for A, and so with the others.""
—Suetonius, Life of Julius Caesar

Ciphers are very straight-forward algorithms that allow us to render text less readable while still allowing easy deciphering.
They are vulnerable to many forms of cryptanalysis, but Caesar was lucky that his enemies were not cryptanalysts.

The Caesar Cipher was used for some messages from Julius Caesar that were sent afield.
Now Caesar knew that the cipher wasn't very good, but he had one ally in that respect: almost nobody could read well.
So even being a couple letters off was sufficient so that people couldn't recognize the few words that they did know.

Your task is to create a simple shift cipher like the Caesar Cipher.
This image is a great example of the Caesar Cipher:

![Caesar Cipher][img-caesar-cipher]

For example:

Giving ""iamapandabear"" as input to the encode function returns the cipher ""ldpdsdqgdehdu"".
Obscure enough to keep our message secret in transit.

When ""ldpdsdqgdehdu"" is put into the decode function it would return the original ""iamapandabear"" letting your friend read your original message.

## Step 2

Shift ciphers quickly cease to be useful when the opposition commander figures them out.
So instead, let's try using a substitution cipher.
Try amending the code to allow us to specify a key and use that for the shift distance.

Here's an example:

Given the key ""aaaaaaaaaaaaaaaaaa"", encoding the string ""iamapandabear""
would return the original ""iamapandabear"".

Given the key ""ddddddddddddddddd"", encoding our string ""iamapandabear""
would return the obscured ""ldpdsdqgdehdu""

In the example above, we've set a = 0 for the key value.
So when the plaintext is added to the key, we end up with the same message coming out.
So ""aaaa"" is not an ideal key.
But if we set the key to ""dddd"", we would get the same thing as the Caesar Cipher.

## Step 3

The weakest link in any cipher is the human being.
Let's make your substitution cipher a little more fault tolerant by providing a source of randomness and ensuring that the key contains only lowercase letters.

If someone doesn't submit a key at all, generate a truly random key of at least 100 lowercase characters in length.

## Extensions

Shift ciphers work by making the text slightly odd, but are vulnerable to frequency analysis.
Substitution ciphers help that, but are still very vulnerable when the key is short or if spaces are preserved.
Later on you'll see one solution to this problem in the exercise ""crypto-square"".

If you want to go farther in this field, the questions begin to be about how we can exchange keys in a secure way.
Take a look at [Diffie-Hellman on Wikipedia][dh] for one of the first implementations of this scheme.

[img-caesar-cipher]: https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Caesar_cipher_left_shift_of_3.svg/320px-Caesar_cipher_left_shift_of_3.svg.png
[dh]: https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange

## Hint

Try using arithmetic operations like modulo to wrap indexes, when exceeded. Character, String classes are your friends too. 
"
Class {
	#name : #SimpleCipherTest,
	#superclass : #ExercismTest,
	#instVars : [
		'simpleCipherCalculator'
	],
	#category : #'Exercise@SimpleCipher'
}

{ #category : #config }
SimpleCipherTest class >> exercise [

	^(ExercismExercise for: self) 
		isCore: false;
		isAutoApproved: true;
		difficulty: 4;
		topics: #('strings' 'string-methods' 'loops' 'numbers' 'lists' 'randomness');
		yourself
]

{ #category : #config }
SimpleCipherTest class >> uuid [
	"Answer a unique id for this exercise"
	^'83b2fe48-3b61-4c08-b711-51fe5b654638'
]

{ #category : #config }
SimpleCipherTest class >> version [
	"Generated from specification: 14 September 2023"
	^'Not specified'
]

{ #category : #running }
SimpleCipherTest >> setUp [
	super setUp.
	simpleCipherCalculator := SimpleCipher new
]

{ #category : #tests }
SimpleCipherTest >> test01_RandomKeyCipherCanEncode [
	"Tip: Remember to review the class [Comment] tab"
	<exeTestName: 'Can encode'>
	<exeTestUUID: 'b8bdfbe1-bea3-41bb-a999-b41403f2b15d'>

	| result |

	result := simpleCipherCalculator encode: 'aaaaaaaaaa'.
	"originally: 'cipher.key.substring(0, plaintext.length)'"
	self assert: result equals: (simpleCipherCalculator key copyFrom: 1 to: 10).
]

{ #category : #tests }
SimpleCipherTest >> test02_RandomKeyCipherCanDecode [
	<exeTestName: 'Can decode'>
	<exeTestUUID: '3dff7f36-75db-46b4-ab70-644b3f38b81c'>

	| result |
	
	"originally: 'cipher.key.substring(0, expected.length)'"
	result := simpleCipherCalculator decode: (simpleCipherCalculator key copyFrom: 1 to: 10).
	self assert: result equals: 'aaaaaaaaaa'
]

{ #category : #tests }
SimpleCipherTest >> test03_RandomKeyCipherIsReversibleIeIfYouApplyDecodeInAEncodedResultYouMustSeeTheSamePlaintextEncodeParameterAsAResultOfTheDecodeMethod [
	<exeTestName: 'Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method'>
	<exeTestUUID: '8143c684-6df6-46ba-bd1f-dea8fcb5d265'>

	| result |

	result := simpleCipherCalculator decode: (simpleCipherCalculator encode: 'abcdefghij').
	self assert: result equals: 'abcdefghij'
]

{ #category : #tests }
SimpleCipherTest >> test04_RandomKeyCipherKeyIsMadeOnlyOfLowercaseLetters [
	<exeTestName: 'Key is made only of lowercase letters'>
	<exeTestUUID: 'defc0050-e87d-4840-85e4-51a1ab9dd6aa'>


	self assert: (simpleCipherCalculator key matchesRegex: '^[a-z]+$').
]

{ #category : #tests }
SimpleCipherTest >> test05_SubstitutionCipherCanEncode [
	<exeTestName: 'Can encode'>
	<exeTestUUID: '565e5158-5b3b-41dd-b99d-33b9f413c39f'>

	| result |

	result := simpleCipherCalculator key: 'abcdefghij'; encode: 'aaaaaaaaaa'.
	self assert: result equals: 'abcdefghij'
]

{ #category : #tests }
SimpleCipherTest >> test06_SubstitutionCipherCanDecode [
	<exeTestName: 'Can decode'>
	<exeTestUUID: 'd44e4f6a-b8af-4e90-9d08-fd407e31e67b'>

	| result |

	result := simpleCipherCalculator key: 'abcdefghij'; decode: 'abcdefghij'.
	self assert: result equals: 'aaaaaaaaaa'
]

{ #category : #tests }
SimpleCipherTest >> test07_SubstitutionCipherIsReversibleIeIfYouApplyDecodeInAEncodedResultYouMustSeeTheSamePlaintextEncodeParameterAsAResultOfTheDecodeMethod [
	<exeTestName: 'Is reversible. I.e., if you apply decode in a encoded result, you must see the same plaintext encode parameter as a result of the decode method'>
	<exeTestUUID: '70a16473-7339-43df-902d-93408c69e9d1'>

	| result |

	result := simpleCipherCalculator key: 'abcdefghij'; encode: 'abcdefghij'.
	self assert: (simpleCipherCalculator decode: result) equals: 'abcdefghij'
]

{ #category : #tests }
SimpleCipherTest >> test08_SubstitutionCipherCanDoubleShiftEncode [
	<exeTestName: 'Can double shift encode'>
	<exeTestUUID: '69a1458b-92a6-433a-a02d-7beac3ea91f9'>

	| result |

	result := simpleCipherCalculator key: 'iamapandabear'; encode: 'iamapandabear' .
	self assert: result equals: 'qayaeaagaciai'
]

{ #category : #tests }
SimpleCipherTest >> test09_SubstitutionCipherCanWrapOnEncode [
	<exeTestName: 'Can wrap on encode'>
	<exeTestUUID: '21d207c1-98de-40aa-994f-86197ae230fb'>

	| result |

	result := simpleCipherCalculator key: 'abcdefghij'; encode: 'zzzzzzzzzz'.
	self assert: result equals: 'zabcdefghi'
]

{ #category : #tests }
SimpleCipherTest >> test10_SubstitutionCipherCanWrapOnDecode [
	<exeTestName: 'Can wrap on decode'>
	<exeTestUUID: 'a3d7a4d7-24a9-4de6-bdc4-a6614ced0cb3'>

	| result |

	result := simpleCipherCalculator key: 'abcdefghij'; decode: 'zabcdefghi'.
	self assert: result equals: 'zzzzzzzzzz'
]

{ #category : #tests }
SimpleCipherTest >> test11_SubstitutionCipherCanEncodeMessagesLongerThanTheKey [
	<exeTestName: 'Can encode messages longer than the key'>
	<exeTestUUID: 'e31c9b8c-8eb6-45c9-a4b5-8344a36b9641'>

	| result |

	result := simpleCipherCalculator key: 'abc'; encode: 'iamapandabear'.
	self assert: result equals: 'iboaqcnecbfcr'
]

{ #category : #tests }
SimpleCipherTest >> test12_SubstitutionCipherCanDecodeMessagesLongerThanTheKey [
	<exeTestName: 'Can decode messages longer than the key'>
	<exeTestUUID: '93cfaae0-17da-4627-9a04-d6d1e1be52e3'>

	| result |

	result := simpleCipherCalculator key: 'abc'; decode: 'iboaqcnecbfcr'.
	self assert: result equals: 'iamapandabear'
]
