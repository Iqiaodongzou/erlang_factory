-module(foo).
-export([main/1]).

-spec kth_factor(N :: integer(), K :: integer()) -> integer().

main([]) ->
    N = 7,
    K = 2,
    Res = kth_factor(N, K),
    io:format("~p~n",[Res]).

kth_factor(N, K) ->
    Seq = lists:seq(1,N),
    Factors = [X || X <- Seq, (N rem X) =:= 0],
    case not(K > length(Factors)) of
        true -> lists:nth(K,Factors);
        false -> -1
    end.

