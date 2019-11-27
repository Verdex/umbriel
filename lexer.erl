
-module(lexer).
-export([lex/1]).

% white space 
lex([$ |Rest], Tokens) -> lex(Rest, Tokens);
lex([$\r|Rest], Tokens) -> lex(Rest, Tokens);
lex([$\n|Rest], Tokens) -> lex(Rest, Tokens);
lex([$\t|Rest], Tokens) -> lex(Rest, Tokens);

% brackets
lex([${|Rest], Tokens) -> lex(Rest, [lcurl|Tokens]);
lex([$}|Rest], Tokens) -> lex(Rest, [rcurl|Tokens]);
lex([$(|Rest], Tokens) -> lex(Rest, [lparen|Tokens]);
lex([$)|Rest], Tokens) -> lex(Rest, [rparen|Tokens]);

% etc
lex([$=|Rest], Tokens) -> lex(Rest, [equal|Tokens]);
lex([$-,$>|Rest], Tokens) -> lex(Rest, [rarrow|Tokens]);

% unknown token
lex([Value|Rest], _) -> {fail, Value, length( Rest )}.


lex(Input) -> 
    case lex(Input, []) of
        {ok, Tokens} -> {ok, lists:reverse( Tokens )};
        Result -> Result
    end .

