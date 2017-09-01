-module(hello).
-export([start/0]).
-export([fac/1]).
-export([main/1]).

start() ->
    io:format("Hello World ~n"),
    init:stop().

main([A]) -> 
    I = list_to_integer(atom_to_list(A)),
    F = fac(I),
    io:format("hello:main ~w => ~w ~n", [I, F]),
    init:stop().

fac(0) -> 1;
fac(N) -> N * fac(N-1).


