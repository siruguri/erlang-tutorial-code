-module(pingpong).
-export([start/0, ping/1, pong/0]).
ping(0) ->
    pong ! finished,
    io:format("ping finished~n", []);
ping(N) -> 
    io:format("sending ping # ~w ~n", [N]),
    pong ! {ping, self()},
    receive
	pong ->
	    io:format("Ping received pong~n", [])
    end,
    ping(N - 1).

pong() ->
    receive
	finished ->
	    io:format("Pong finished~n", []);
	{ping, Ping_PID} ->
	    io:format("Pong received ping~n", []),
	    Ping_PID ! pong,
	    pong()
    end.
start() ->
    register(pong, spawn(pingpong, pong, [])),
    spawn(pingpong, ping, [3]).
