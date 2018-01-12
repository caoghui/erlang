-module(total).
-export([total/1, total2/1, total3/1]).


%verion1
total([])              -> 0;
total([{What, N} | T]) -> shop:cost(What) * N + total(T).

%version2
total2(L) ->lib_misc:sum(lib_misc:map(fun({What, N}) -> shop:cost(What) * N end, L)).

%version3 使用列表推导
total3(L) -> lists:sum([shop:cost(A)*B || {A, B} <- L]) .
