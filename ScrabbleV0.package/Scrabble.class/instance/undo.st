accessing
undo
	undo ifNil: [ undo := Stack new ].
	^ undo ifEmpty: [ nil ] ifNotEmpty: [ undo pop ]