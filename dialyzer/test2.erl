-module(test2).
-export([f1/0]).

f1() ->
    tuple_size(list_to_tuple({1,2,4})).
