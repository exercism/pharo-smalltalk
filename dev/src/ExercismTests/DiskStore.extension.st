Extension { #name : 'DiskStore' }

{ #category : '*ExercismTests' }
DiskStore class >> currentFileSystem: fileSystem during: aBlock [
	| backupFileSystem |
	backupFileSystem := self currentFileSystem.
	[ CurrentFS := fileSystem.
	aBlock value ]
		ensure: [  CurrentFS:= backupFileSystem ]
]
