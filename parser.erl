
-module(parser).
-export([parse/1]).

% parse expr
parse_expr([{string, Value}|Rest]) -> {ok, {string, Value}, Rest};
parse_expr([{int, Value}|Rest]) -> {ok, {int, Value}, Rest};
parse_expr([{symbol, Value}|Rest]) -> {ok, {var, Value}, Rest};
parse_expr([]) -> fail.



% parse let parameter list
parse_let_param_list([{symbol, Name}|Rest], Params) -> 
    parse_let_param_list(Rest, [{param, Name}|Params]);

parse_let_param_list([equal|Rest], Params) -> {ok, Params, Rest}.

% parse let
parse_module_items([{symbol, "let"}, {symbol, ValName}|Rest], Items) -> 
    case parse_let_param_list(Rest, []) of
        {ok, Params, ParamRest} -> ok;
        Else -> fail
    end,
    
    case parse_expr(Rest) of
        {ok, Expr, ExprRest} -> ok;
        Else -> fail
    end.


% parse open
parse_module_items([{symbol, "open"}, {symbol, OpenName}, semicolon|Rest], Items) ->
    parse_module_items(Rest, [{open_def, OpenName}|Items]);
    
% end of module definition
parse_module_items([rcurl|Rest], Items) -> {ok, Items, Rest}.


% parse modules
parse_modules([{symbol, "mod"}, {symbol, ModName}, lcurl|Rest], Modules) -> 
    case parse_module_items(Rest, []) of
        {ok, Items, ItemRest} -> parse_modules(ItemRest, [{module, Items}|Modules]),
        Else -> Else
    end .

% end of tokens
parse_modules([], Modules) -> {ok, Modules};

% unknown token
parse_modules(_, _) -> fail.

parse(Tokens) ->
    case parse_modules(Tokens, []) of
        {ok, Modules} -> { ok, Modules },
        Else -> Else
    end .
