wait_key(ValidKeys, ReturnedKey) :-
get_single_char(X),
char_code(Y, X),
(member(Y, ValidKeys) ->
ReturnedKey = Y;
wait_key(ValidKeys, K), ReturnedKey = K
).
