"
# Diffie Hellman

Diffie-Hellman key exchange.

Alice and Bob use Diffie-Hellman key exchange to share secrets.  They
start with prime numbers, pick private keys, generate and share public
keys, and then generate a shared secret key.

## Step 0

The test program supplies prime numbers p and g.

## Step 1

Alice picks a private key, a, greater than 1 and less than p.  Bob does
the same to pick a private key b.

## Step 2

Alice calculates a public key A.

    A = g**a mod p

Using the same p and g, Bob similarly calculates a public key B from his
private key b.

## Step 3

Alice and Bob exchange public keys.  Alice calculates secret key s.

    s = B**a mod p

Bob calculates

    s = A**b mod p

The calculations produce the same result!  Alice and Bob now share
secret s.

## Hint

TBD

"
Class {
	#name : #DiffieHellmanTest,
	#superclass : #ExercismTest,
	#instVars : [
		'diffieHellmanCalculator'
	],
	#category : #'ExercismWIP-DiffieHellman'
}

{ #category : #config }
DiffieHellmanTest class >> uuid [
	"Answer a unique id for this exercise"
	^'df87cabb-8040-0d00-810f-fe8c01deb008'
]

{ #category : #config }
DiffieHellmanTest class >> version [
	"Generated from specification: 15 March 2019"
	^'1.0.0'
]

{ #category : #setup }
DiffieHellmanTest >> setUp [
	diffieHellmanCalculator := DiffieHellman new
]

{ #category : #tests }
DiffieHellmanTest >> test01_PrivateKeyIsInRange1P [
	| result |

	result := diffieHellmanCalculator privateKeyIsInRange.
	self assert: result equals: ((Dictionary new) add: ('greaterThan'->1); add: ('lessThan'->'p'); yourself)
]

{ #category : #tests }
DiffieHellmanTest >> test02_PrivateKeyIsRandom [
	| result |

	result := diffieHellmanCalculator privateKeyIsRandom.
	self assert: result equals: ((Dictionary new) add: ('random'->true); yourself)
]

{ #category : #tests }
DiffieHellmanTest >> test03_CanCalculatePublicKeyUsingPrivateKey [
	| result |

	result := diffieHellmanCalculator publicKeyP: 23 g: 5 privateKey: 6 .
	self assert: result equals: 8
]

{ #category : #tests }
DiffieHellmanTest >> test04_CanCalculateSecretUsingOtherPartysPublicKey [
	| result |

	result := diffieHellmanCalculator secretTheirPublicKey: 19 p: 23 myPrivateKey: 6 .
	self assert: result equals: 2
]

{ #category : #tests }
DiffieHellmanTest >> test05_KeyExchange [
	| result |

	result := diffieHellmanCalculator keyExchangeBobPublicKey: 'publicKey(p, g, bobPrivateKey)' g: 5 p: 23 alicePrivateKey: 'privateKey(p)' bobPrivateKey: 'privateKey(p)' secretA: 'secret(p, bobPublicKey, alicePrivateKey)' alicePublicKey: 'publicKey(p, g, alicePrivateKey)' secretB: 'secret(p, alicePublicKey, bobPrivateKey)' .
	self assert: result equals: 'secretA == secretB'
]
