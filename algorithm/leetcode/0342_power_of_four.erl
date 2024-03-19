-module(foo).
-export([main/1]).

-spec is_power_of_four(N :: integer()) -> boolean().

main([]) ->
    R = is_power_of_four(16),
    io:format("~p~n",[R]).

is_power_of_four(N) ->
  (N > 0) and
  (N band (N - 1) == 0) and
  (N band 16#55555555 == N).
