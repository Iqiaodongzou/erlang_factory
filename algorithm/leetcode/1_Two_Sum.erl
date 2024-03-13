-module(foo).
-export([main/1]).

-spec two_sum(Nums :: [integer()], Target :: integer()) -> [integer()].

main([]) ->
    Nums = [3,2,4],
    Target = 6,
    Res = two_sum(Nums,Target),
    io:format("~p~n",[Res]).

two_sum(Nums, Target) ->
    SeqNums = lists:zip(lists:seq(1,length(Nums)),Nums),
    Remains = [Index-1 || {Index,X} <- SeqNums, lists:member(Target-X,Nums--[X])].

