%option noyywrap

%{
#include "cal.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

"do"                { return DO; }
"while"             { return WHILE; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
";"                 { return SEMICOLON; }
"<="                { return LE; }
">="                { return GE; }
"=="                { return EQ; }
"!="                { return NE; }
"<"                 { return LT; }
">"                 { return GT; }
"="                 { return ASSIGN; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return MULTIPLY; }
"/"                 { return DIVIDE; }
"%"                 { return MOD; }
[0-9]+              { yylval.ival = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.sval = strdup(yytext); return IDENTIFIER; }
[ \t\r\n]+          { /* skip whitespace */ }
.                   { return yytext[0]; }

%%
