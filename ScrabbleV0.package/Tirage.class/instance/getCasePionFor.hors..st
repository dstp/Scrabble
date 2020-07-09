automate
getCasePionFor: aStr hors: cases
	| aCase |
	aCase := (self tirage reject: [ :c | (cases indexOf: c) > 0 ]) detect: [ :c | c isNotEmpty and: [ c pion isJocker not and: [ c pion lettre = aStr ] ] ] ifNone: [ nil ].
	^ aCase
		ifNil: [ aCase := self tirage detect: [ :c | c isNotEmpty and: [ c pion isJocker ] ] ifNone: [ nil ].
			aCase
				ifNil: [ nil ]
				ifNotNil: [ aCase pion jocker: aStr.
					aCase ] ]
		ifNotNil: [ aCase ]