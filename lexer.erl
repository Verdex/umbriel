
-module(lexer).
-export([lex/1]).

-define(is_start_symbol(S), (is_integer(S)
                            and (((S >= $a) and (S =< $z))
                              or ((S >= $A) and (S =< $Z))
                              or (S == $_)))).

-define(is_symbol(S), (is_integer(S)
                      and (((S >= $a) and (S =< $z))
                        or ((S >= $A) and (S =< $Z))
                        or ((S >= $0) and (S =< $9))
                        or (S == $_)))).

% symbol
lex_symbol([], Chars, Tokens) -> 
    lex([], [{symbol, lists:reverse(Chars)}|Tokens]);
lex_symbol([S|Rest], Chars, Tokens) when not ?is_symbol(S) -> 
    lex([S|Rest], [{symbol, lists:reverse(Chars)}|Tokens]);
lex_symbol([S|Rest], Chars, Tokens) when ?is_symbol(S) -> 
    lex_symbol(Rest, [S|Chars], Tokens).

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

% punctuation 
lex([$=|Rest], Tokens) -> lex(Rest, [equal|Tokens]);
lex([$-,$>|Rest], Tokens) -> lex(Rest, [rarrow|Tokens]);

% symbol
lex([S|Rest], Tokens) when ?is_start_symbol(S) -> lex_symbol(Rest, [S], Tokens);

% end of file
lex([], Tokens) -> {ok, Tokens};

% unknown token
lex([Value|Rest], _) -> {fail, Value, length( Rest )}.


lex(Input) -> 
    case lex(Input, []) of
        {ok, Tokens} -> {ok, lists:reverse( Tokens )};
        Result -> Result
    end .

