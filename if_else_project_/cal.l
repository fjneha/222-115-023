%option noyywrap

%{
    #include "cal.tab.h"
    #include <string.h>
%}

%%

"if"            { return IF; }
"else"          { return ELSE; }
"printf"        { return PRINTF; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
"=="            { return EQ; }
"="             { return ASSIGN; }
"%"             { return MOD; }
";"             { return SEMI; }
","             { return COMMA; }
\"[^\"]*\"      { yylval.sval = strdup(yytext); return STRING; }
[0-9]+          { yylval.ival = atoi(yytext); return INT_NUM; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.sval = strdup(yytext); return ID; }
[ \t\r\n]+      { /* skip whitespace */ }
.               { return *yytext; }

%%
