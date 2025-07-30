%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int ival;
    char* sval;
}

%token DO WHILE LPAREN RPAREN LBRACE RBRACE SEMICOLON
%token LT LE GT GE EQ NE
%token PLUS MINUS MULTIPLY DIVIDE MOD ASSIGN
%token <ival> NUMBER
%token <sval> IDENTIFIER

%%

program:
    DO LBRACE stmt_list RBRACE WHILE LPAREN condition RPAREN SEMICOLON
    {
        printf("✅ Valid do-while loop syntax detected.\n");
    }
    ;

condition:
    expression relop expression
    ;

relop:
      LT
    | LE
    | GT
    | GE
    | EQ
    | NE
    ;

expression:
      NUMBER
    | IDENTIFIER
    | expression PLUS expression
    | expression MINUS expression
    | expression MULTIPLY expression
    | expression DIVIDE expression
    | expression MOD expression
    ;

stmt_list:
      /* empty */
    | stmt_list statement
    ;

statement:
    IDENTIFIER ASSIGN expression SEMICOLON
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "❌ Syntax Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
