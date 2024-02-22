Extension { #name : #Class }

{ #category : #'*ExercismPharo110' }
Class >> removeFromSystem: logged [
	"Forget the receiver from the Smalltalk global dictionary. Any existing  instances will refer to an obsolete version of the receiver.
	Keep the class name and category for triggering the system change message. If we wait to long, then we get obsolete information which is not what we want.
	Tell class to deactivate and unload itself-- two separate events in the module system"
	| myCategory |
	self release.
	self unload.

	self superclass ifNotNil:
		["If we have no superclass there's nothing to be remembered"
		self superclass addObsoleteSubclass: self].

	"we add the class to Undeclared so that if references still exist, they will  be automatically fixed
	if this class is loaded again. We do not check if references exist as it is too slow"
	self binding value: nil.
	Undeclared declare: self name asSymbol from: Smalltalk globals.
	myCategory := self category.
	self environment forgetClass: self logged: logged.
	self obsolete.
	logged ifTrue: [SystemAnnouncer uniqueInstance classRemoved: self fromCategory: myCategory]
]
