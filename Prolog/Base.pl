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
    readLinesFromSTream(Stream, List),
    close(Stream).
