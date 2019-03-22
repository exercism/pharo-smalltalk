"
I invert the storage of score/letter storage. While efficiency is not always the most crucial aspect of a soution, iterating over the dictionary associations (v.s. just value or just the keys) makes this solution quite trivial.
"
Class {
	#name : #Etl,
	#superclass : #Object,
	#category : #'Exercism-Etl'
}

{ #category : #exercism }
Etl >> transformData: tileDictionary [
	"Iterate over the input score/letter association to avoid an extra dictionary lookup"
	
	^ tileDictionary associations
		inject: Dictionary new
		into: [ :result :scoreLettersPair | 
			scoreLettersPair value
				do: [ :letter | 
					result at: letter asLowercase put: scoreLettersPair key asNumber ].
			result ]
]
