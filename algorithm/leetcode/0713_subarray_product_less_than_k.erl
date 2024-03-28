-module(foo).
-export([main/1]).

-spec num_subarray_product_less_than_k(Nums :: [integer()], K :: integer()) -> integer().

main([]) ->
    Nums = [10,5,2,6],
    K = 100,
    R = num_subarray_product_less_than_k(Nums,K),
    io:format("~p~n",[R]).

num_subarray_product_less_than_k(Nums, K) ->
    SubLen = (2 bsl (length(Nums) - 1)) - 1,
    MapLen = length(traverse_bits(SubLen)),
    Maps = lists:seq(1,SubLen),
    % generate a binary map to collect sub array
    R = [pad_right(traverse_bits(N),MapLen) || N <- Maps,has_consecutive_ones(N)],
    SubArray = [array_collector(Nums,Map) || Map <- R],
    Res = [N || N <- SubArray,product(N,1) < K],
    length(Res).
 
product([H|T],Acc) ->
    product(T,Acc*H);

product([],Acc) ->
    Acc.

traverse_bits(Num) when is_integer(Num) ->
    traverse_bits(Num, []).

traverse_bits(0, Bits) ->
    lists:reverse(Bits);
traverse_bits(Num, Bits) ->
    traverse_bits(Num bsr 1, [Num band 1 | Bits]).

pad_right(Array, Length) when is_list(Array) ->
    Padding = lists:duplicate(Length - length(Array), 0),
    Array ++ Padding.

array_collector(Nums,Map) ->
    Kmap = lists:zip(Map,Nums),
    R = [X || {1,X} <- Kmap],
    R.


% is leagal number to generate map?
has_consecutive_ones(Number) ->
    BinStr = list_to_binary(integer_to_list(Number, 2)),
    BinList = binary:split(BinStr,<<"0">>,[global]),
    OneSeg = [X || X <- BinList,binary_to_list(X) =/= []],
    length(OneSeg) =:= 1.

