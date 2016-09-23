-module(reverse).
-export([reverse_list/1]).

reverse_list(List) ->
    reverse_list(List, []).

reverse_list([], List) ->
    List;
reverse_list([Head|Rest], List_now) ->
    reverse_list(Rest, [Head|List_now]).
