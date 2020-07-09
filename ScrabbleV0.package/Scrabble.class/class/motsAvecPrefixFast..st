lesMots
motsAvecPrefixFast: unPrefix
	"retourne un ByteString avec les mots séparés par des espaces"

	"ici on utilise une SortedCollection"

	^ ' '
		join:
			(self dictDesMotsKeys
				select: [ :k | k >= unPrefix asUppercase and: [ k < (unPrefix asUppercase , 'ZZZ') ] ]
				thenCollect: [ :k | k ])