dico
dictDesMotsKeys
	^ dictDesMotsKeys ifNil: [ dictDesMotsKeys := self getDictDesMots keys asOrderedCollection sort]