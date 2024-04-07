-module(foo).
-export([main/1]).

-spec max_depth(S :: unicode:unicode_binary()) -> integer().

main([]) ->
    S = <<"(1+(2*3)+((8)/4))+1">>,
    R = max_depth(S),
    io:format("~p~n",[R]).

max_depth(S) ->
    Seq = binary_to_list(S),
    Max = depth_loop(Seq,0,0).

depth_loop([],Count,Max) ->
    Max;

depth_loop([H|T],Count,Max) ->
    case H of
        40 -> NewCount = Count+1;
        41 -> NewCount = Count-1;
        _ -> NewCount = Count
    end,
    NewMax = max(NewCount,Max),
    depth_loop(T,NewCount,NewMax).

