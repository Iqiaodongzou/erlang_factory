-module(foo).
-export([main/1]).

-spec array_strings_are_equal(Word1 :: [unicode:unicode_binary()], Word2 :: [unicode:unicode_binary()]) -> boolean().

main([]) ->
    Word1 = ["ab", "c"],
    Word2 = ["a", "bc"],
    R = array_strings_are_equal(Word1, Word2),
    io:format("~p~n",[R]).

array_strings_are_equal(Word1, Word2) ->
    iolist_to_binary(Word1) =:= iolist_to_binary(Word2).

