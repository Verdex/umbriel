
-module(test).
-export([start/0]).

lex_symbol() -> 
    {ok, Tokens} = lexer:lex("symbol_123"),
    [{symbol, "symbol_123"}] = Tokens,
    ok.

lex_string() -> 
    {ok, Tokens} = lexer:lex("\"string123\""),
    [{string, "string123"}] = Tokens,
    ok.

lex_int() -> 
    {ok, Tokens} = lexer:lex("123"),
    [{int, "123"}] = Tokens,
    ok.

lex_neg_int() -> 
    {ok, Tokens} = lexer:lex("-123"),
    [{int, "-123"}] = Tokens,
    ok.

start() -> 
    ok = lex_symbol(),
    ok = lex_string(),
    ok = lex_int(),
    ok = lex_neg_int().

