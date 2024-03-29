-module(foo).
-export([main/1]).

-spec count_subarrays(Nums :: [integer()], K :: integer()) -> integer().

main([]) ->
    Nums = [1,4,2,1],
    K = 2,
    R = count_subarrays(Nums,K),
    io:format("~p~n",[R]).

count_subarrays(Nums, K) ->
    Max = lists:max(Nums),
    Cnt = 0,
    Left = 0,
    Ans = 0,
    [_,_,_,R,_,_] = count_loop(Nums,[Max,Cnt,Left,Ans,K,Nums]),
    R.

count_loop([H|T],Acc) ->
    [Max,Cnt,Left,Ans,K,Nums] = Acc,
    case H =:= Max of
        true -> NCnt = Cnt + 1;
        false -> NCnt = Cnt
    end,
    case NCnt =:= K of
        true -> [NewCnt,NewLeft] = left_loop(true,NCnt,Left,K,Nums,Max);
        false -> NewCnt = NCnt,
                 NewLeft = Left
    end,
    NewAns = Ans + NewLeft,
    count_loop(T,[Max,NewCnt,NewLeft,NewAns,K,Nums]);

count_loop([],Acc) ->
    Acc.

left_loop(true,Cnt,Left,K,Nums,Max) ->
    Flag = (lists:nth(Left+1,Nums) =:= Max),
    case Flag of
        true -> NewCnt = Cnt - 1;
        false -> NewCnt = Cnt
    end,
    Flag2 = (NewCnt =:= K),
    left_loop(Flag2,NewCnt,Left+1,K,Nums,Max);

left_loop(false,Cnt,Left,K,Nums,Max) ->
    [Cnt,Left].

