-module(event_handler).
-export([make/1, add_handler/2, event/2]).
%%test
-export([no_op/1]).
-ifdef(debug).
-define(log(X), io:format("{~p:~p}: ~p~n", [?MODULE,?LINE,X])).
-else.
-define(log(X), true).
-endif.
%%导入测试函数
-import(lib_log, [log_debug/1, log_debug/3]).

%%制作一个名为Name的新事件处理器，处理函数是no_op
make(Name) ->
    register(Name, spawn(fun() -> my_handler(fun no_op/1) end)).

add_handler(Name, Fun) ->
    Name ! {add, Fun}.

%%生成一个事件
event(Name, X) ->
    Name ! {event, X}.

%%internel function
my_handler(Fun) ->
    receive
        {add, Fun1} ->
            my_handler(Fun1);
        {event, Any} ->
            (catch Fun(Any)),
            my_handler(Fun)
    end.

no_op(X) -> 
%    log(X).
    log_debug(?MODULE, ?LINE, X).
%    io:format("[~p:~p]~w~n", [?MODULE, ?LINE, X]).