accessing
getPionsMot: unMot
	"
	A revoir, pourquoi ces valeurs nil ?
	"

	^ unMot asUppercase
		inject: OrderedCollection new
		into: [ :aOC :let | 
			| lstP |
			lstP := (self jeu pionsOwner: self) asArray
				select: [ :p | 
					let = $*
						ifTrue: [ p isJocker ]
						ifFalse: [ p lettre first = let ] ].
			lstP isEmpty
				ifTrue: [ aOC ]
				ifFalse: [ aOC
						add:
							(lstP first
								owner: nil";
								whereIs: nil");
						yourself ] ]