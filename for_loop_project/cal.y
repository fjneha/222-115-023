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

%token FOR LPAREN RPAREN LBRACE RBRACE SEMICOLON
%token LT LE GT GE EQ NE
%token PLUS MINUS MULTIPLY DIVIDE MOD
%token ASSIGN INC DEC
%token <ival> NUMBER
%token <sval> IDENTIFIER

%%

program:
    FOR LPAREN assignment SEMICOLON condition SEMICOLON increment RPAREN LBRACE stmt_list RBRACE
    {
        printf("✅ Valid for-loop syntax detected.\n");
    }
    ;

assignment:
    IDENTIFIER ASSIGN expression
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

increment:
      IDENTIFIER INC
    | IDENTIFIER DEC
    | IDENTIFIER ASSIGN expression
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
    IDENTIFIER LPAREN IDENTIFIER RPAREN SEMICOLON
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "❌ Syntax Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
