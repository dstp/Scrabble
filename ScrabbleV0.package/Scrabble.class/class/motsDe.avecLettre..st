lesMots
motsDe: n avecLettre: aLet
	| reg |
	reg := ('\w*' , aLet , '\w*') asRegex.
	(self dictDesMots keys
		select: [ :k | k size <= n and: [ reg matches: k ] ]
		thenCollect: [ :k | k ]) sort
		do: [ :m | 
			Transcript
				show: m;
				cr ]