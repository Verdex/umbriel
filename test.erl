
-module(test).
-export([start/0]).

lex_symbol() -> 
    Input = "symbol_123",
    {ok, Tokens} = lexer:lex(Input),
    [{symbol, "symbol_123"}] = Tokens,
    ok.

start() -> 
    ok = lex_symbol().
