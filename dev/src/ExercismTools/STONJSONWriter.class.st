"
I am a simple JSON writer that lets you specify configuation in JSON like:

data := { 
	'id'-> 123. 
	'language' -> 'english'.
	'exercises' -> {
		'name' -> 'hello'.
		'topics' -> #('a' 'b' 'c') }
	}. 
	
String streamContents: [ :stream |
	(STONJSONWriter on: stream) nextPut: data  ].

It is assumed that key order is important and so all Dictionaries are converted to OrderedDictionary when writing out the JSON
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
			newLine: String lf;
			yourself
]

{ #category : #'instance creation' }
STONJSONWriter class >> streamContentsOf: anObject [
	"Answer a String, the results of streaming the writer contents for anObject (simple conveniance method)"
	
	^String streamContents: [ :stream |
			(self on: stream) nextPut: anObject ]
]

{ #category : #writing }
STONJSONWriter >> newlineIndent [
	"Override to adopt a json space identation convention"

	prettyPrint
		ifTrue: [ writeStream nextPutAll: newLine.
			level timesRepeat: [ writeStream space: 2 ] ]
]

{ #category : #writing }
STONJSONWriter >> writeAssociation: association [
	"Overriden to support associations"
	
	self 
		encodeKey: association key 
		value: association value
]

{ #category : #writing }
STONJSONWriter >> writeObject: anObject do: block [
	"Overridden to support Collections and Dictionaries"
	
	jsonMode ifTrue: [ 
		(anObject isKindOf: OrderedCollection)
			ifTrue: [ ^self writeList: anObject ].
		(anObject isKindOf: OrderedDictionary)
			ifTrue: [ ^self writeMap: anObject ].
		(anObject isKindOf: Dictionary)
			ifTrue: [ ^self writeMap: anObject asOrderedDictionary ]].
		
	super writeObject: anObject do: block 
]
