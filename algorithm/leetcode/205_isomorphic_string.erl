-module(foo).
-export([main/1]).

-spec is_isomorphic(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().

main([]) ->
    S = <<"bbbaaaba">>,
    T = <<"aaabbbba">>,
    R = is_isomorphic(S, T),
    io:format("~p~n",[R]).

is_isomorphic(S, T) ->
    R = isomo_loop(binary_to_list(S),binary_to_list(T),sets:new(), sets:new()).

isomo_loop([], [], _, _) ->
    true;
isomo_loop([SChar | RestS], [TChar | RestT], SToTMap, TToSMap) ->
    case {sets:is_element({SChar,TChar}, SToTMap), sets:is_element({TChar,SChar}, TToSMap)} of
        {TChar, SChar} ->
            isomo_loop(RestS, RestT, SToTMap, TToSMap);
        {true, true} ->
            isomo_loop(RestS, RestT, sets:add_element({SChar,TChar}, SToTMap), sets:add_element({TChar,SChar}, TToSMap));
        {false, false} ->
            L1 = proplists:get_value(SChar,sets:to_list(SToTMap)),
            L2 = proplists:get_value(TChar,sets:to_list(TToSMap)),
            case {L1,L2} of
                {undefined,undefined} ->
                    isomo_loop(RestS, RestT, sets:add_element({SChar,TChar}, SToTMap), sets:add_element({TChar,SChar}, TToSMap));
                _ -> false
            end;
        _ ->
            false
    end.

