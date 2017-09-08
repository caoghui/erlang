-module(walks).
-export([start/0, plan_route/2]).

-spec plan_route(From::point(), To::point()) -> route().
-spec plan_route1(From::position(), To::position()) -> route().
-type direction() ::north | south | east | west.
-type point()     ::{integer(), integer()}.
-type route()     ::[{go, direction(), integer()}].
-type angle()     ::{Degrees::0..360, Minutes::0..60, Seconds::0..60}.
-type position()  ::{latitude|longitude, angle()}.


plan_route(From, To) ->
    [{go, north, 23}].

plan_route1(From, To) ->
    {go, north, 25}.
start() ->
    io:format("Hello walks~n").