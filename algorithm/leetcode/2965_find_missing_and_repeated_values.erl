-module(foo).
-export([main/1]).

-spec find_missing_and_repeated_values(Grid :: [[integer()]]) -> [integer()].

main([]) ->
    Nums = [[9,1,7],[8,9,2],[3,4,6]],
    Res = find_missing_and_repeated_values(Nums),
    io:format("~p~n",[Res]).

find_missing_and_repeated_values(Grid) ->
    FlatList = lists:append(Grid),
    Seq = lists:seq(1,length(FlatList)),
    Repeated = FlatList -- Seq,
    Missing = Seq -- FlatList,
    Res = lists:append(Repeated,Missing).
