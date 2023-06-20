Extension { #name : #String }

{ #category : #'*Exercise@WordSearch' }
String >> -->> aCollectionOfAssociations [
	"Similar to -> but converts aCollection to aDictionary, useful when building JSON structures"

	^self -> aCollectionOfAssociations asDictionary 
]
