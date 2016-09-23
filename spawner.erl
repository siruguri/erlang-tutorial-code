-module(spawner).
-export([start/0, say_it/2]).

say_it(What, 0) ->
    ok;
say_it(What, Times) ->
    io:format("~p~n", [What]),
    say_it(What, Times - 1).

start() ->
    spawn(spawner, say_it, ["hello", 3]),
    spawn(spawner, say_it, ["bye", 5]).
