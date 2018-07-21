cubeMatrix(
    [[000, 000, 000, 101, 101, 101, 000, 000, 000],
     [000, 000, 000, 101, 101, 101, 000, 000, 000],
     [000, 000, 000, 101, 101, 101, 000, 000, 000],
     [102, 102, 102, 103, 103, 103, 044, 044, 044],
     [102, 102, 102, 103, 103, 103, 044, 044, 044],
     [102, 102, 102, 103, 103, 103, 044, 044, 044],
     [000, 000, 000, 045, 045, 045, 000, 000, 000],
     [000, 000, 000, 045, 045, 045, 000, 000, 000],
     [000, 000, 000, 045, 045, 045, 000, 000, 000],
     [000, 000, 000, 100, 100, 100, 000, 000, 000],
     [000, 000, 000, 100, 100, 100, 000, 000, 000],
     [000, 000, 000, 100, 100, 100, 000, 000, 000]]
).
     
assetsPath("../Assets").

lineLimit(500).

rows(Width)  :- tty_size(Width, _).
cols(Height) :- tty_size(_, Height).

cubeOriginRow(0).
cuboMidCol(X) :- cols(Y), X is Y // 2 - 75 // 2.

esc("\e").

readLinesFromSTream(Stream, []) :-
    at_end_of_stream(Stream).
    
readLinesFromSTream(Stream, [Head|Tail]) :-
    read_line_to_string(Stream, Head),
    readLinesFromSTream(Stream, Tail).

readFileLines(FileName, List) :- 
    open(FileName, read, Stream),
    readLinesFromSTream(Stream, List),!,
	close(Stream).

ruleForFrameNames(Name, Frame) :-
	member(NameWithoutSep, ['0Left', '1Left', '2Left', '0Right', '1Right',
	'2Right', 'AUp', 'BUp', 'CUp', 'ADown', 'BDown', 'CDown', 'aClockwise',
	'bClockwise', 'cClockwise', 'aCounterclockwise', 'bCounterclockwise',
	'cCounterclockwise']),

	atom_concat(NameWithoutSep, '_', NameWithUnderline),

	between(0, 4, Number),

	atom_number(NumberAtom, Number),
	
	atom_concat(NameWithUnderline, NumberAtom, Name),

	assetsPath(AssetsPath),
	string_concat(AssetsPath, "/Cubo", CubePath),

	string_concat(CubePath, "/", CubePathBar),

	string_concat(CubePathBar, NameWithoutSep, CubePathBarName),

	string_concat(CubePathBarName, "/", CubePathBarNameBar),

	atom_string(NumberAtom, NumberString),

	string_concat(CubePathBarNameBar, NumberString, CubePathBarNameBarAnim),

	string_concat(CubePathBarNameBarAnim, ".txt", CubePathBarNameBarAnimTxt),

	readFileLines(CubePathBarNameBarAnimTxt, Frame).

loadAnimations() :-
	assetsPath(AssetsPath),
	string_concat(AssetsPath, "/Cubo", CubePath),

	string_concat(CubePath, "/Default.txt", PathOfDefault),
	readFileLines(PathOfDefault, AnimationOfDefault),

	Animations = _{'Default': AnimationOfDefault},



	writeln(Animations).
