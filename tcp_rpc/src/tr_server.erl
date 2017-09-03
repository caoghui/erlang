%%%--------------------------------------首部-------------------------------------
%%%-------------------------------------------------------------------------------
%%% @author Bruce <258214414@qq.com>
%%% @copyright 2017
%%% @doc RPC over TCP Server. This module defines a server process that
%%%      listens for incoming TCP connections and allows the user to execute
%%%      RPC commands via that TCP stream.
%%% @end
%%%-------------------------------------------------------------------------------
%模块属性
-module(tr_server).
%行为模式属性
-behaviour(gen_server).

%单元测试
-include_lib("eunit/include/eunit.hrl").

%%%----------------------------------导出声明---------------------------------------
%% API
-export([start_link/1, start_link/0, get_count/0, stop/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% unit test
%-export([start_test/0]).

%% 将SERVER设置为模块名
-define(SERVER, ?MODULE).

%% 定义默认端口
-define(DEFAULT_PORT, 1055).

%% 用于保存进程状态
-record(state, {port, lsock, request_count = 0}).
%%%--------------------------------------end-------------------------------------------

%%%-------------------------------------%%%
%%%----------------API 段---------------%%%
%%%-------------------------------------%%%
%%-----------------------------------------
%% @doc starts the server
%%
%% @spec start_link(Port::integer()) -> {ok, Pid}
%% where 
%%    Pid = pid()
%% @end
%%-----------------------------------------
start_link(Port) ->
    gen_server:start_link({local, ? SERVER}, ?MODULE, [Port], [] ).

%% @spec start_link() -> {ok, Pid}
%% @doc Calls "start_link(Port)" using the default port.
start_link() ->
    start_link(? DEFAULT_PORT).

%% @doc Fetches the number of requests made to this server
%% @spec get_count() -> {ok, Count}
%% where
%% Count = Integer()
%% @end
get_count() ->
    gen_server:call(?SERVER,  get_count).

%% @doc Stops the server
%% @spec stop() -> ok
%% @end
stop() ->
    gen_server:cast(?SERVER, stop).

%%%-----------------------------------------------%%%
%%%--------------gen_server callback 段-----------%%%
%%%-----------------------------------------------%%%
init([Port]) ->
    {ok, LSock} = gen_tcp:listen(Port, [{active, true}]),
    {ok, #state{port = Port, lsock = LSock}, 0}.

handle_call(get_count, _Form, State) ->
    {reply, {ok, State#state.request_count}, State}.

handle_cast(stop, State) ->
    {stop, normal, State}.

handle_info({tcp, Socket, RawData}, State) ->
    do_rpc(Socket, RawData),
    RequestCount = State#state.request_count,
    {noreply, State#state{request_count = RequestCount + 1}};
handle_info(timeout, #state{lsock = LSock} = State) ->
    {ok, _Sock} = gen_tcp:accept(LSock),
    {noreply, State}.

terminate(_Reason, _State) -> 
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%-----------------------------------------------%%%
%%%--------------Internal functions-----------%%%
%%%-----------------------------------------------%%%
do_rpc(Socket, RawData) ->
    try
        {M, F, A} = split_out_mfa(RawData),
        Result = apply(M, F, A),
        gen_tcp:send(Socket, io_lib:fwrite("~p~n", [Result]))
    catch
        _Class:Err ->
            gen_tcp:send(Socket, io_lib:fwrite("~p~n", [Err]))
    end.

split_out_mfa(RawData) ->
    MFA = re:replace(RawData, "\r\n$", "", [{return, list}]),
    {match, [M, F, A]} = re:run(MFA, 
                                "(.*):(.*)\s*\\((.*)\s*\\)\s*.\s*$", 
                                [{capture, [1, 2, 3], ungreedy}]),
    {list_to_atom(M), list_to_atom(F), args_to_terms(A)}.

args_to_terms(RawArgs) ->
    {ok, Toks, _Line} = erl_scan:string("[" ++ RawArgs ++ "]. ", 1),
    {ok, Args} = erl_parse:parse_term(Toks),
    Args.

%%% 测试函数
start_test() ->
    io:format("Hello TCP RPC Server ~n"),
    init:stop().

%%%----------------end---------------