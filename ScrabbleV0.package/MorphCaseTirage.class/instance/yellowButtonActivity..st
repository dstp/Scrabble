event handling
yellowButtonActivity: shiftKeyState
	self wantsYellowButtonMenu
		ifFalse: [ ^ false ].

	(self owner jeu getMenu: shiftKeyState)
		ifNotNil: [ :menu | 
			menu setInvokingView: self.
			menu popUpEvent: self activeHand lastEvent in: self world.
			^ true ].
	^ true