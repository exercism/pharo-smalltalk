Extension { #name : #ZnMimePart }

{ #category : #'*ExercismTools' }
ZnMimePart class >> exercismFieldName: fieldName fileName: fileName entity: entity [
	"Copied from ZnMimePart class >> fieldName:fileName:entity:
	 with space added after 'form-data;' as required by Exercism server, 
	 otherwise we get Response(500 INTERNAL SERVER ERROR).
	 Space added after second semi-colon just for looks."
	
	"Pathnames are often silenty encoded using UTF-8,
	this is a no-op for ASCII, but will fail on Latin-1 and others"

	| encodedFileName |
	encodedFileName := fileName utf8Encoded asString.
	^ self new
		setContentDisposition: 'form-data; name="', fieldName, '"; filename="', encodedFileName, '"';
		entity: entity;
		yourself

]
