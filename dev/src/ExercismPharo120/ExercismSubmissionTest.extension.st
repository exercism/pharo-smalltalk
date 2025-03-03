Extension { #name : 'ExercismSubmissionTest' }

{ #category : '*ExercismPharo120' }
ExercismSubmissionTest class >> mockSnapshotSTON [
^	'MCSnapshot {
	#definitions : OrderedCollection [
		MCOrganizationDefinition {
			#packageName : #''Exercise@DependencyMock'',
			#tagNames : [ ]
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethod ^ \''Call from class: \'', self class name'',
			#category : #''as yet unclassified'',
			#selector : #mockMethod,
			#className : #CMock
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethod ^ CMock mockMethod'',
			#category : #''as yet unclassified'',
			#selector : #mockMethod,
			#className : #BMock
		},
		MCMethodDefinition {
			#classIsMeta : false,
			#source : ''mockMethod ^ BMock mockMethod'',
			#category : #''as yet unclassified'',
			#selector : #mockMethod,
			#className : #AMock
		},
		MCClassDefinition {
			#name : #CMock,
			#superclassName : #Object,
			#variables : OrderedCollection [ ],
			#packageName : #''Exercise@DependencyMock'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		},
		MCClassDefinition {
			#name : #BMock,
			#superclassName : #CMock,
			#variables : OrderedCollection [ ],
			#packageName : #''Exercise@DependencyMock'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		},
		MCClassDefinition {
			#name : #AMock,
			#superclassName : #BMock,
			#variables : OrderedCollection [ ],
			#packageName : #''Exercise@DependencyMock'',
			#type : #normal,
			#comment : '''',
			#commentStamp : '''',
			#traitComposition : ''{}'',
			#classTraitComposition : ''{}''
		}
	],
	#classDefinitionCache : {
		#AMock : @12,
		#CMock : @8,
		#BMock : @10
	}
}'
]

{ #category : '*ExercismPharo120' }
ExercismSubmissionTest class >> prepareMockPackageWithDependentClasses [
" this is used for generating STON representation of MCSnapshot (see class side method), we don't need to create classes during test"
|aClass bClass cClass aPackage|

	cClass := Object << #CMock
		slots: {};
		sharedVariables: {};
		package: 'Exercise@DependencyMock';
		install.
		
	bClass := (self class environment at: #CMock) << #BMock
		slots: {};
		sharedVariables: {};
		package: 'Exercise@DependencyMock';
		install.

	aClass := (self class environment at: #BMock) << #AMock
		slots: {};
		sharedVariables: {};
		package: 'Exercise@DependencyMock';
		install.

	aClass compile: 'mockMethod ^ BMock mockMethod'.
	bClass compile: 'mockMethod ^ CMock mockMethod'.
	cClass compile: 'mockMethod ^ ''Call from class: '', self class name'.

	aPackage := PackageOrganizer default packageNamed: 'Exercise@DependencyMock'.
	^ TonelWriter new toSTON: aPackage snapshot.
]
