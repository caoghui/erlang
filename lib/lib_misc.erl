-module(lib_misc).
%-export([for/3, sum/1, map/2, map2/2, qsort/1,pythag/1,perms/1]).
-compile(export_all).

-ifdef(debug_flag).
-define(DEBUG(X), io:format("DEBUG ~p: ~p ~p~n", [?MODULE, ?LINE, X])).
-else.
-define(DEBUG(X), void).
-endif.

loop(0) -> done;
loop(N) -> ?DEBUG(N), loop(N-1).

for(Max, Max, F) -> [F(Max)];
for(I,   Max, F) -> [F(I) | for(I+1, Max, F)].

sum(L)        ->sum(L, 0).
sum([], N)    -> N;
sum([H|T], N) -> sum(T, H+N).

map(_, [])    -> [] ;
map(F, [H|T]) -> [F(H) | map(F, T)].

map2(F, L) -> [F(X) || X <- L].


qsort([])         -> [];
qsort([Privot|T]) -> 
    qsort([X || X <- T, X < Privot])
    ++ [Privot] ++
    qsort([X || X <- T, X >= Privot]).

pythag(N) ->
    [ {A, B, C} || 
         A <- lists:seq(1, N),
         B <- lists:seq(1, N),
         C <- lists:seq(1, N),
         A + B + C =< N,
         A*A + B*B =:= C*C
    ].

perms([]) -> [[]];
perms(L)  -> [[H|T] || H <- L, T <- perms(L -- [H])].

odds_and_evensl(L) ->
    Odds  = [ X || X <- L, (X rem 2) =:= 1],
    Evens = [ X || X <- L, (X rem 2) =:= 0],
    {Odds, Evens}.

odds_and_evens2(L) ->
    odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> odds_and_evens_acc(T, [H|Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H|Evens])
    end;
odds_and_evens_acc([], Odds, Evens) ->
    {lists:reverse(Odds), lists:reverse(Evens)}.