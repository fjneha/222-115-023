%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int num = 7; // hardcoded value for demonstration
    void yyerror(const char *s);
    int yylex();
%}

%union {
    int ival;
    char *sval;
}

%token <ival> INT_NUM
%token <sval> ID STRING
%token IF ELSE PRINTF
%token ASSIGN EQ MOD SEMI COMMA
%token LPAREN RPAREN LBRACE RBRACE

%%

program:
    if_stmt
    ;

if_stmt:
    IF LPAREN ID MOD INT_NUM EQ INT_NUM RPAREN LBRACE print_even RBRACE ELSE LBRACE print_odd RBRACE {
        if (num % $5 == $7) {
            printf("%d is even.\n", num);
        } else {
            printf("%d is odd.\n", num);
        }
    }
    ;

print_even:
    PRINTF LPAREN STRING COMMA ID RPAREN SEMI
    ;

print_odd:
    PRINTF LPAREN STRING COMMA ID RPAREN SEMI
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
