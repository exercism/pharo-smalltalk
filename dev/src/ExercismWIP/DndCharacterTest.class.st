"
# Dnd Character

For a game of [Dungeons & Dragons][DND], each player starts by generating a
character they can play with. This character has, among other things, six
abilities; strength, dexterity, constitution, intelligence, wisdom and
charisma. These six abilities have scores that are determined randomly. You
do this by rolling four 6-sided dice and record the sum of the largest three
dice. You do this six times, once for each ability.

Your character's initial hitpoints are 10 + your character's constitution
modifier. You find your character's constitution modifier by subtracting 10
from your character's constitution, divide by 2 and round down.

Write a random character generator that follows the rules above.

For example, the six throws of four dice may look like:

* 5, 3, 1, 6: You discard the 1 and sum 5 + 3 + 6 = 14, which you assign to strength.
* 3, 2, 5, 3: You discard the 2 and sum 3 + 5 + 3 = 11, which you assign to dexterity.
* 1, 1, 1, 1: You discard the 1 and sum 1 + 1 + 1 = 3, which you assign to constitution.
* 2, 1, 6, 6: You discard the 1 and sum 2 + 6 + 6 = 14, which you assign to intelligence.
* 3, 5, 3, 4: You discard the 3 and sum 5 + 3 + 4 = 12, which you assign to wisdom.
* 6, 6, 6, 6: You discard the 6 and sum 6 + 6 + 6 = 18, which you assign to charisma.

Because constitution is 3, the constitution modifier is -4 and the hitpoints are 6.

## Notes

Most programming languages feature (pseudo-)random generators, but few
programming languages are designed to roll dice. One such language is [Troll].

[DND]: https://en.wikipedia.org/wiki/Dungeons_%26_Dragons
[Troll]: http://hjemmesider.diku.dk/~torbenm/Troll/

## Hint

TBD

"
Class {
	#name : #DndCharacterTest,
	#superclass : #ExercismTest,
	#instVars : [
		'dndCharacterCalculator'
	],
	#category : #'ExercismWIP-DndCharacter'
}

{ #category : #config }
DndCharacterTest class >> uuid [
	"Answer a unique id for this exercise"
	^'fc3626da-2b3f-0d00-a2fb-c40009f0590c'
]

{ #category : #config }
DndCharacterTest class >> version [
	"Generated from specification: 26 February 2019"
	^'1.1.0'
]

{ #category : #setup }
DndCharacterTest >> setUp [
	dndCharacterCalculator := DndCharacter new
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore10Is0 [
	| result |

	result := dndCharacterCalculator modifierScore: 10 .
	self assert: result equals: 0
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore11Is0 [
	| result |

	result := dndCharacterCalculator modifierScore: 11 .
	self assert: result equals: 0
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore12Is1 [
	| result |

	result := dndCharacterCalculator modifierScore: 12 .
	self assert: result equals: 1
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore13Is1 [
	| result |

	result := dndCharacterCalculator modifierScore: 13 .
	self assert: result equals: 1
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore14Is2 [
	| result |

	result := dndCharacterCalculator modifierScore: 14 .
	self assert: result equals: 2
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore15Is2 [
	| result |

	result := dndCharacterCalculator modifierScore: 15 .
	self assert: result equals: 2
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore16Is3 [
	| result |

	result := dndCharacterCalculator modifierScore: 16 .
	self assert: result equals: 3
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore17Is3 [
	| result |

	result := dndCharacterCalculator modifierScore: 17 .
	self assert: result equals: 3
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore18Is4 [
	| result |

	result := dndCharacterCalculator modifierScore: 18 .
	self assert: result equals: 4
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore3Is4 [
	| result |

	result := dndCharacterCalculator modifierScore: 3 .
	self assert: result equals:  -4
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore4Is3 [
	| result |

	result := dndCharacterCalculator modifierScore: 4 .
	self assert: result equals:  -3
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore5Is3 [
	| result |

	result := dndCharacterCalculator modifierScore: 5 .
	self assert: result equals:  -3
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore6Is2 [
	| result |

	result := dndCharacterCalculator modifierScore: 6 .
	self assert: result equals:  -2
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore7Is2 [
	| result |

	result := dndCharacterCalculator modifierScore: 7 .
	self assert: result equals:  -2
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore8Is1 [
	| result |

	result := dndCharacterCalculator modifierScore: 8 .
	self assert: result equals:  -1
]

{ #category : #test }
DndCharacterTest >> testAbilityModifierAbilityModifierForScore9Is1 [
	| result |

	result := dndCharacterCalculator modifierScore: 9 .
	self assert: result equals:  -1
]

{ #category : #test }
DndCharacterTest >> testEachAbilityIsOnlyCalculatedOnce [
	| result |

	result := dndCharacterCalculator strength.
	self assert: result equals: 'strength == strength'
]

{ #category : #test }
DndCharacterTest >> testRandomAbilityIsWithinRange [
	| result |

	result := dndCharacterCalculator ability.
	self assert: result equals: 'score >= 3 && score <= 18'
]

{ #category : #test }
DndCharacterTest >> testRandomCharacterIsValid [
	| result |

	result := dndCharacterCalculator character.
	self assert: result equals: ((Dictionary new) add: ('charisma'->'charisma >= 3 && charisma <= 18'); add: ('intelligence'->'intelligence >= 3 && intelligence <= 18'); add: ('wisdom'->'wisdom >= 3 && wisdom <= 18'); add: ('strength'->'strength >= 3 && strength <= 18'); add: ('constitution'->'constitution >= 3 && constitution <= 18'); add: ('dexterity'->'dexterity >= 3 && dexterity <= 18'); add: ('hitpoints'->'hitpoints == 10 + modifier(constitution)'); yourself)
]
