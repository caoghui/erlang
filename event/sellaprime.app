{
    application, 
    sellaprime,
    [
        {description, "The Prime number Shop"},
        {vsn, "1.0"},
        {modules, [sellaprime_app, sellaprime_supersivor, area_server, 
         prime_server, lib_lin, lib_primes, my_alarm_handler ]},
        {regiested, [area_server, prime_server, sellaprime_super]},
        {applications, [kernel, stdlib]},
        {mod, {sellaprime_app, []}},
        {start_phases, []}
    ]
}.