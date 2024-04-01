-module(foo).
-export([main/1]).

-spec length_of_last_word(S :: unicode:unicode_binary()) -> integer().

main([]) ->
    S = <<"Hello world   ">>,
    R = length_of_last_word(S),
    io:format("~p~n",[R]).


length_of_last_word(S) ->
    WordList = binary:split(S,<<" ">>,[global]),
    Notnull = [X || X <- WordList,binary_to_list(X) =/= []],
    case Notnull =:= [] of
        true -> 0;
        false -> length(binary_to_list(lists:last(Notnull)))
    end.

