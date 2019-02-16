"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestExercismTools,
	#superclass : #PackageManifest,
	#category : #'ExercismTools-Manifest'
}

{ #category : #'code-critics' }
ManifestExercismTools class >> ruleReTestClassNameShouldEndWithTestV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#Welcome)) #'2019-02-15T12:32:33.510625+00:00') )
]

{ #category : #'code-critics' }
ManifestExercismTools class >> ruleReTestClassNotInPackageWithTestEndingNameV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#Welcome)) #'2019-02-15T12:32:43.874674+00:00') )
]
