-module(foo).
-export([main/1]).

-record(list_node, {val = 0 :: integer(),
                    next = null :: 'null' | #list_node{}}).

-spec remove_zero_sum_sublists(Head :: #list_node{} | null) -> #list_node{} | null.

main([]) ->
    Node4 = #list_node{val=1, next=null},
    Node3 = #list_node{val=3, next=Node4},
    Node2 = #list_node{val=-3, next=Node3},
    Node1 = #list_node{val=2, next=Node2},
    Head = #list_node{val=1, next=Node1},
    Res = remove_zero_sum_sublists(Head),
    io:format("~p~n",[Res]).

remove_zero_sum_sublists(Head) ->
    Next = Head#list_node.next,
    NodeList = loop(Head,Next),
    NodeList.

loop(Node,null) ->
    Val = [Node#list_node.val],
    Val;

loop(Node,NextNode) ->
    Acc = [Node#list_node.val | loop(NextNode,NextNode#list_node.next)],
    Acc.

