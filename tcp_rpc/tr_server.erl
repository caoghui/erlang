%%%----------------首部---------------
%%%---------------------------------------------------------------
%%% @author Bruce <258214414@qq.com>
%%% @copyright 2017
%%% @doc RPC over TCP Server. This module defines a server process that
%%%      listens for incoming TCP connections and allows the user to execute
%%%      RPC commands via that TCP stream.
%%% @end
%%%---------------------------------------------------------------

-module(tr_server).      %模块属性
-behaviour(gen_server).  %行为模式属性

%%% 导出声明
%% API
-export([start_link/1, start_link/0, get_count/0, stop/0]).
%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-defines(SERVER, ?MODULE).     %将SERVER设置为模块名
-defines(DEFAULT_PORT, 1055).  %定义默认端口
-record(state, {port, lsock, request_count = 0}).  %用于保存进程状态
%% 测试函数
-export([start/0]).  
%%%----------------end---------------

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
    gen_server::start_link({local, ?SERVER}, ?MODULE, [Port], [] ).

%% @spec start_link() -> {ok, Pid}
%% @doc Calls "start_link(Port)" using the default port.
start_link() ->
    start_link(?DEFAULT_PORT).

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




%%% 测试函数
start() ->
    io:format("Hello TCP RPC Server ~n"),
    init:stop().

%%%----------------end---------------