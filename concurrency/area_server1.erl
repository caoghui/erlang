-module(area_server1).
-export([start/0, area/2,loop/0, rpc/2]).

start() ->
    spawn(area_server1, loop, []).

area(Pid, What) ->
    rpc(Pid, What).

rpc(Pid, Request) ->
    io:format("a request will be send to ~p, msg:~p ~n", [Pid, Request]),
    Pid ! {self(), Request},
    receive
        {Pid, Response} ->
            io:format("a response receive. res:~p~n", [Response]),
            Response
    end.

loop() ->
    receive
        {From, {rectangle, Width, Height}} ->
            From ! {self(), Width * Height},
            loop();
        {From, {circle, R}} ->
            From ! {self(), 3.14 * R * R},
            loop();
        {From, Other} ->
            From ! {self(), {error, Other}},
            loop()
    end.