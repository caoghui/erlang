-module(user_default).
-compile(export_all).

hello() ->
    "Hello, This message from user_default.erl".

away(Time) ->
    io:format("I am away and will be back in ~w minutes~n",[Time]).