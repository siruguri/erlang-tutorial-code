-module(io_egs).
-export([show_line/1]).

show_line(List) ->
    io:format("this outputs two Erlang terms: ~w ~w~n", List).
