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

ruleForCubeFrameNames(Name, Frame) :-
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

ruleForLogoFrameNames(Name, Frame) :-
	between(0, 43, Number),
	atom_number(NumberAtom, Number),
	atom_concat('Logo_', NumberAtom, Name),

	assetsPath(AssetsPath),

	string_concat(AssetsPath, "/Logo/", PathWithLogo),

	atom_string(NumberAtom, NumberString),

	string_concat(PathWithLogo, NumberString, PathWithLogoNumber),

	string_concat(PathWithLogoNumber, ".txt", FullPath),

	readFileLines(FullPath, Frame).

inserListOfTuplesInDict(Dict, [(Key, Value)|[]], DictOut) :-
	DictOut = Dict.put(Key, Value).

inserListOfTuplesInDict(Dict, [(Key, Value)|Tail], DictOut) :-
	inserListOfTuplesInDict(Dict, Tail, DictOutAux), DictOut = DictOutAux.put(Key, Value).

loadAnimations(Animations) :-
	assetsPath(AssetsPath),
	string_concat(AssetsPath, "/Cubo", CubePath),

	string_concat(CubePath, "/Default.txt", PathOfDefault),
	readFileLines(PathOfDefault, AnimationOfDefault),

	AnimationsWithOnlyDefault = _{'Default': AnimationOfDefault},

	findall((X, Y), ruleForCubeFrameNames(X, Y), ListCube),

	inserListOfTuplesInDict(AnimationsWithOnlyDefault, ListCube, AnimationsWithDefaultAndCube),

	findall((X, Y), ruleForLogoFrameNames(X, Y), ListLogo),

	inserListOfTuplesInDict(AnimationsWithDefaultAndCube, ListLogo, Animations).
