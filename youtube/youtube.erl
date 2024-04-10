-module(foo).
-export([main/1]).

main([]) ->
	Url = "https://www.youtube.com/watch?v=N1rgAOqF3Qw&list=PLsNJO0nl_IhSMN7kx1hrQK_zPBAPXH_NB",
	R = start(Url),
	io:format("~p~n",[R]).

start(Url) ->
	inets:start(),
	ssl:start(),
	ibrowse:start(),
	case ibrowse:send_req(Url, [], get) of
		{ok,Code,Header,Body} ->
			R = handle_body(Body),
			ok;
		Ohter ->
			error
	end.
 
handle_body(Body) ->
	Bin = list_to_binary(Body),
	JanBin = binary:split(Bin,<<":{\"playlist\":">>,[global]),
	FebBin = lists:last(JanBin),
	MarBin = binary:split(FebBin,<<"},\"autoplay\":">>,[global]),
	AprBin = lists:nth(1,MarBin),
	file:write_file("apr.txt",AprBin),
	May = jsx:decode(AprBin,[{return_maps,false}]),
	Res = handle_playlist(May),
	ok.

handle_playlist(Item) ->
	Jan = proplists:get_value(<<"contents">>,Item,[]),
	Res = [prepare_url(X) || X <- Jan],
	ok.

prepare_url(Item) ->
	Title = prepare_title(Item),
	Jan = proplists:get_value(<<"playlistPanelVideoRenderer">>,Item,[]),
	Feb = proplists:get_value(<<"navigationEndpoint">>,Jan,[]),
	Mar  = proplists:get_value(<<"commandMetadata">>,Feb,[]),
	Apr  = proplists:get_value(<<"webCommandMetadata">>,Mar,[]),
	May  = proplists:get_value(<<"url">>,Apr,[]),
	Url = iolist_to_binary(["https://www.youtube.com",May]),
	io:format("~p~n ~p~n",[Url,Title]),
	ok.

prepare_title(Item) ->
	Jan = proplists:get_value(<<"playlistPanelVideoRenderer">>,Item,[]),
	Feb = proplists:get_value(<<"title">>,Jan,[]),
	Mar  = proplists:get_value(<<"accessibility">>,Feb,[]),
	Apr  = proplists:get_value(<<"accessibilityData">>,Mar,[]),
	Label = proplists:get_value(<<"label">>,Apr,[]),
	Label.

