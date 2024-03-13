-module(foo).
-export([main/1]).

-spec pivot_integer(N :: integer()) -> integer().

main([]) ->
    Num = 19,
    Res = pivot_integer(Num),
    io:format("~p~n",[Res]).

pivot_integer(N) ->
    All = lists:seq(1,N),
    CurP = round(N/2),
    Map = lists:seq(CurP,length(All)),
    Flag = [Cur || Cur <- Map,find_pivot(All,Cur) =:= 0],
    case Flag =:= [] of
        true -> -1;
        false -> lists:last(Flag)
    end.

find_pivot(All,CurP) ->
    {Pre,PreSuf} = lists:split(CurP,All),
    Suf = lists:append([length(Pre)],PreSuf),
    Flag = lists:sum(Suf) - lists:sum(Pre).

