menu
finDePartie
	self joueur pions
		ifEmpty: [ | nP undoArr |
			nP := (self robot pions asArray collect: [ :p | p valeur ]) reduce: [ :a :b | a + b ].
			self joueur pts: self joueur pts + nP .
			undoArr := self undo.
			undoArr at: 4 put: (undoArr at: 4) + nP .
			self undo: undoArr.
			].
	self robot pions
		ifEmpty: [ | nP undoArr |
			nP := (self joueur pions asArray collect: [ :p | p valeur ]) reduce: [ :a :b | a + b ].
			self robot pts: self robot pts + nP .
			undoArr := self undo.
			undoArr at: 4 put: (undoArr at: 4) + nP .
			self undo: undoArr.].
	self morph afficheScores