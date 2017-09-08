-module(lib_log).
-export([log_debug/1, log_debug/3]).

-ifdef(debug).
-define(LOG(X), io:format("{~p,~p}: ~p~n", [?MODULE,?LINE,X])).
-else.
-define(LOG(X), true).
-endif.

log_debug(X) ->
    io:format("[~p:~p] : ~w~n", [?MODULE, ?LINE, X]).

log_debug(M, L, X) ->
    io:format("[~p:~p] : ~w~n", [M, L, X]).
