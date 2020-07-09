lesMots
motsDe: n avecLettres: let
	| res |
	res := OrderedCollection new.
	let
		permutationsDo: [ :each | 
			| reg |
			reg := ('\w*' , ('\w*' join: each asArray) , '\w*') asRegex.
			res addAll: (self dictDesMots keys select: [ :k | k size = n and: [ reg matches: k ] ] thenCollect: [ :k | k ]) sort ].
	^ res
	"do: [ :m | 
			Transcript
				show: m;
				cr ]"