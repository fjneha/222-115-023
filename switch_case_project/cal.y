%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int choice = 2; // hardcoded input
    void yyerror(const char *s);
    int yylex();
%}

%union {
    int ival;
    char *sval;
}

%token <ival> INT_NUM
%token <sval> ID STRING
%token SWITCH CASE DEFAULT BREAK PRINTF
%token SEMI COMMA COLON
%token LPAREN RPAREN LBRACE RBRACE

%%

program:
    switch_stmt
    ;

switch_stmt:
    SWITCH LPAREN ID RPAREN LBRACE case_list default_case RBRACE
    ;

case_list:
    case_list case
    | /* empty */
    ;

case:
    CASE INT_NUM COLON statements
    ;

default_case:
    DEFAULT COLON statements
    | /* empty */
    ;

statements:
    statements statement
    | statement
    ;

statement:
    PRINTF LPAREN STRING RPAREN SEMI {
        // Determine which message to print based on 'choice'
        if (strcmp($3, "\"You chose One.\\n\"") == 0 && choice == 1) {
            printf("You chose One.\n");
        } else if (strcmp($3, "\"You chose Two.\\n\"") == 0 && choice == 2) {
            printf("You chose Two.\n");
        } else if (strcmp($3, "\"You chose Three.\\n\"") == 0 && choice == 3) {
            printf("You chose Three.\n");
        } else if (strcmp($3, "\"Invalid choice.\\n\"") == 0 && (choice < 1 || choice > 3)) {
            printf("Invalid choice.\n");
        }
    }
    | BREAK SEMI
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
