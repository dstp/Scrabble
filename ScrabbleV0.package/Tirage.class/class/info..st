utility
info: maxVal
			Transcript
				show: (maxVal at: 1) asString;
				show: ' points avec : ';
				show: (maxVal at: 2);
				show: ' (';
				show: (maxVal at: 3) asString;
				show: ' ';
				show: (maxVal at: 4) asString;
				show: ' ) ';
				show:
					((maxVal at: 5)
						ifTrue: [ 'Horizontal' ]
						ifFalse: [ 'Vertical' ]);
				cr;
				flush.