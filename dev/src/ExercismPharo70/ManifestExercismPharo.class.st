"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestExercismPharo,
	#superclass : #PackageManifest,
	#category : #'ExercismPharo70-Manifest'
}

{ #category : #'code-critics' }
ManifestExercismPharo class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DoesNotUnderstandDebugAction #defaultProtocol #false)) #'2019-05-12T13:53:13.954721+08:00') )
]
