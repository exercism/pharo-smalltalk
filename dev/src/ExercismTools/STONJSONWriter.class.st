"
I am a simple JSON writer that lets you specify configuation like JSON like:

data := { 
	'id'-> 123. 
	'language' -> 'english'.
	'exercises' -> {
		'name' -> 'hello'.
		'topics' -> #('a' 'b' 'c') }
	}.
	
String streamContents: [ :stream |
	(STONJSONWriter on: stream) writeList: data ].
"
Class {
	#name : #STONJSONWriter,
	#superclass : #STONWriter,
	#category : #'ExercismTools-Core'
}

{ #category : #'instance creation' }
STONJSONWriter class >> on: writeStream [
	^ (super on: writeStream)
			jsonMode: true;
			prettyPrint: true;
			yourself
]

{ #category : #writing }
STONJSONWriter >> writeAssociation: association [
	
	self 
		encodeKey: association key 
		value: association value
]

{ #category : #writing }
STONJSONWriter >> writeObject: anObject do: block [
	
	jsonMode ifTrue: [ 
		(anObject isKindOf: OrderedCollection)
			ifTrue: [ ^self writeList: anObject ].
		(anObject isKindOf: OrderedDictionary)
			ifTrue: [ ^self writeMap: anObject ]].
		
	super writeObject: anObject do: block 
]
