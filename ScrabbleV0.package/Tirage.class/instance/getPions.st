accessing
getPions
	"self unsetAndSetLesPions."

	self putPions: self getPionsFromSac.
	self updWithJocker .
	^ self pions