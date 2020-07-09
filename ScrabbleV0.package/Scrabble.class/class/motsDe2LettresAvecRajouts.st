lesMots
motsDe2LettresAvecRajouts
	^ ((self dictDesMots keys
		select: [ :k | k size = 2 ]
		thenCollect: [ :k | k ]) sort
		inject: (WriteStream with: String new)
		into: [ :ws :m | 
			ws
				nextPutAll: (self asByteString: (self uneLetAvant: m)) sort;
				space;
				nextPutAll: m;
				space;
				nextPutAll: (self asByteString: (self uneLetApres: m)) sort;
				cr;
				yourself ]) contents