-module(foo).
-export([main/1]).

-spec count_students(Students :: [integer()], Sandwiches :: [integer()]) -> integer().

main([]) ->
    Students = [0,0,0,1,0,1,1,1,1,0,1],
    Sandwiches = [0,0,0,1,0,0,0,0,0,1,0],
    R = count_students(Students, Sandwiches),
    io:format("~p~n",[R]).

count_students(Students, Sandwiches) ->
    All = length(Students),
    case Students -- Sandwiches of
        [] -> 0;
        _ -> count_loop(Students, Sandwiches, 0, All)
    end.

count_loop([PH|PT], [SH|ST], Count,All) ->
    Flag = lists:member(SH,[PH]++PT),
    case Flag of
        true -> 
          case PH =:= SH of
            true -> count_loop(PT, ST, Count+1, All);
            false -> count_loop(PT++[PH], [SH]++ST, Count, All)
          end;
        false -> count_loop([], ST, Count, All)
    end;

count_loop([], ST, Count, All) ->
    All - Count.

