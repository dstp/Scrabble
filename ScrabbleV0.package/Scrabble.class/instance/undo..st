accessing
undo: anObject
	anObject
		ifNil: [ undo := Stack new ]
		ifNotNil: [ undo ifNil: [ undo := Stack new ] . undo push: anObject ] 