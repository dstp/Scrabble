"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestScrabbleV',
	#superclass : 'PackageManifest',
	#category : 'ScrabbleV0',
	#package : 'ScrabbleV0'
}

{ #category : 'meta-data' }
ManifestScrabbleV class >> description [ ^ 'Test'
]

{ #category : 'code-critics' }
ManifestScrabbleV class >> ruleBadMessageRuleV1FalsePositive [
	^ #()
]

{ #category : 'code-critics' }
ManifestScrabbleV class >> ruleClassNotReferencedRuleV1FalsePositive [
	^ #()
]
