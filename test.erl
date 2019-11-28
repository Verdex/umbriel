
-module(test).
-export([start/0]).

lex_symbol() -> 
    Input = "symbol",
    {ok, Tokens} = lexer:lex(Input),
    [{symbol, "symbol"}] = Tokens,
    ok.

start() -> 
    ok = lex_symbol().
