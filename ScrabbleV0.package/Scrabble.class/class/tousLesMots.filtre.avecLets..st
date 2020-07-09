private
tousLesMots: desLettres filtre: aFiltre avecLets: aOC
	"
	"

	| aSet n filtre lets |
	aSet := Set new.
	n := self asSizeFiltre: aFiltre.
	n = 0
		ifTrue: [ ^ aSet ].
	filtre := self filtre: aFiltre.
	lets := self asByteString: aOC.
	^ self tousLesMots: desLettres  de: n filtre: filtre  avecLet: lets . 
