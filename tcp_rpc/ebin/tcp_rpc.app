%% mode:erlang
{
    application, 
    tcp_rpc,
    [
        { description, "RPC Server for Erlang and OTP in action" },
        { vsn, "0.1.0" },
        { modules, [tr_app, tr_sup, tr_server] },
        { registered, [tr_sup] },
        { applicatons, [kernel, stdlib] },
        { mod, {tr_app, []}}
    ]
}.