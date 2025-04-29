%{
#include "parser.tab.h"
#include <string.h>
%}

%option noyywrap

LETRA [a-zA-Z]
DIGITO [0-9]
ID {LETRA}({LETRA}|{DIGITO})*
CTE_INT {DIGITO}+
CTE_FLOAT {DIGITO}+\.{DIGITO}+
CTE_STRING \"[^"]*\"

%%

"program"   { return TOKEN_PROGRAM; }
"main"      { return TOKEN_MAIN; }
"end"       { return TOKEN_END; }
"var"       { return TOKEN_VAR; }
"int"       { return TOKEN_INT; }
"float"     { return TOKEN_FLOAT; }
"void"      { return TOKEN_VOID; }
"if"        { return TOKEN_IF; }
"else"      { return TOKEN_ELSE; }
"while"     { return TOKEN_WHILE; }
"do"        { return TOKEN_DO; }
"print"     { return TOKEN_PRINT; }

{ID}        { yylval.sval = strdup(yytext); return TOKEN_ID; }
{CTE_INT}   { yylval.ival = atoi(yytext); return TOKEN_CTE_INT; }
{CTE_FLOAT} { yylval.fval = atof(yytext); return TOKEN_CTE_FLOAT; }
{CTE_STRING} { yylval.sval = strdup(yytext); return TOKEN_CTE_STRING; }

"+"         { return TOKEN_PLUS; }
"-"         { return TOKEN_MINUS; }
"*"         { return TOKEN_MULT; }
"/"         { return TOKEN_DIV; }
">"         { return TOKEN_GT; }
"<"         { return TOKEN_LT; }
"!="        { return TOKEN_NE; }
"="         { return TOKEN_ASSIGN; }

";"         { return TOKEN_SEMICOLON; }
":"         { return TOKEN_COLON; }
","         { return TOKEN_COMMA; }
"{"         { return TOKEN_LBRACE; }
"}"         { return TOKEN_RBRACE; }
"("         { return TOKEN_LPAREN; }
")"         { return TOKEN_RPAREN; }


[ \t\n]+    ;


.           { fprintf(stderr, "Error lexico: Caracter inesperado '%s'\n", yytext); }

%%
