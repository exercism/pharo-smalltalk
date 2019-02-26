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
	^'1b4dffd9-2b3f-0d00-a2d9-4e7609f0590c'
]

{ #category : #config }
DiffieHellmanTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.0.0'
]

{ #category : #setup }
DiffieHellmanTest >> setUp [
	diffieHellmanCalculator := DiffieHellman new
]

{ #category : #test }
DiffieHellmanTest >> testCanCalculatePublicKeyUsingPrivateKey [
	| result |

	result := diffieHellmanCalculator publicKeyP: 23 g: 5 privateKey: 6 .
	self assert: result equals: 8
]

{ #category : #test }
DiffieHellmanTest >> testCanCalculateSecretUsingOtherPartysPublicKey [
	| result |

	result := diffieHellmanCalculator secretTheirPublicKey: 19 p: 23 myPrivateKey: 6 .
	self assert: result equals: 2
]

{ #category : #test }
DiffieHellmanTest >> testKeyExchange [
	| result |

	result := diffieHellmanCalculator keyExchangeBobPublicKey: 'publicKey(p, g, bobPrivateKey)' g: 5 p: 23 alicePrivateKey: 'privateKey(p)' bobPrivateKey: 'privateKey(p)' secretA: 'secret(p, bobPublicKey, alicePrivateKey)' alicePublicKey: 'publicKey(p, g, alicePrivateKey)' secretB: 'secret(p, alicePublicKey, bobPrivateKey)' .
	self assert: result equals: 'secretA == secretB'
]

{ #category : #test }
DiffieHellmanTest >> testPrivateKeyIsInRange1P [
	| result |

	result := diffieHellmanCalculator privateKeyIsInRange.
	self assert: result equals: ((Dictionary new) add: ('greaterThan'->1); add: ('lessThan'->'p'); yourself)
]

{ #category : #test }
DiffieHellmanTest >> testPrivateKeyIsRandom [
	| result |

	result := diffieHellmanCalculator privateKeyIsRandom.
	self assert: result equals: ((Dictionary new) add: ('random'->true); yourself)
]
