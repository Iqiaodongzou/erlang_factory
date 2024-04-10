-module(foo).
-export([main/1]).

-spec time_required_to_buy(Tickets :: [integer()], K :: integer()) -> integer().

main([]) ->
    Tickets = [5,1,1,1],
    K = 0,
    R = time_required_to_buy(Tickets, K),
    io:format("~p~n",[R]).

time_required_to_buy(Tickets, K) ->
    X = lists:nth(K+1,Tickets),
    R = time_loop(Tickets,K,X,0,0).

time_loop([H|T],K,X,Count,I) ->
    Buy = case I > K of
            true -> X - 1;
            false -> X
    end,
    time_loop(T,K,X,Count+min(Buy,H),I+1);

time_loop([],K,X,Count,I) ->
    Count.

