-module(foo).
-export([main/1]).

-spec hamming_weight(N :: integer()) -> integer().

main([]) ->
    N = 15,
    R = hamming_weight(N),
    io:format("~p~n",[R]).

hamming_weight(N) ->
    count_ones(N,0).

count_ones(0,Acc) -> Acc;
count_ones(N,Acc) ->
    count_ones(N bsr 1,Acc + (N band 1)).

