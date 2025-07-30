%option noyywrap

%{
    #include "cal.tab.h"
    #include <string.h>
%}

%%

"switch"        { return SWITCH; }
"case"          { return CASE; }
"default"       { return DEFAULT; }
"break"         { return BREAK; }
"printf"        { return PRINTF; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
":"             { return COLON; }
";"             { return SEMI; }
","             { return COMMA; }
\"[^\"]*\"      { yylval.sval = strdup(yytext); return STRING; }
[0-9]+          { yylval.ival = atoi(yytext); return INT_NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.sval = strdup(yytext); return ID; }
[ \t\r\n]+      { /* skip whitespace */ }
.               { return *yytext; }

%%
