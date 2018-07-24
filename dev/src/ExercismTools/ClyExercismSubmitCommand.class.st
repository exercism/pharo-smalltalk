Class {
	#name : #ClyExercismSubmitCommand,
	#superclass : #SycPackageCommand,
	#category : #ExercismTools
}

{ #category : #activation }
ClyExercismSubmitCommand class >> defaultMenuItemName [
	^'Submit to Exercism'
]

{ #category : #activation }
ClyExercismSubmitCommand class >> packageContextMenuActivation [
	<classAnnotation>
	
	^CmdContextMenuCommandActivation 
		byItemOf: ClyQueryMenuGroup for: RPackage asCalypsoItemContext 
]

{ #category : #execution }
ClyExercismSubmitCommand >> execute [
	| files writer result cmd |
	writer := TonelWriter new.
	files := packages
		inject: OrderedCollection new
		into: [ :res :pkg | 
			writer
				sourceDir: '.' asFileReference;
				writeSnapshot: (MCPackage named: pkg name) snapshot.
			res addAll: pkg classes ].
		
	cmd := 'exercism submit ',
			(Character space
				join: (files collect: [ :cls | writer fileNameFor: cls asClassDefinition ])).
				
	result := PipeableOSProcess waitForCommand: cmd.
	UIManager default inform: cmd, ' -> ',result output, '.'
]
