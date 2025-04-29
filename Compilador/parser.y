%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


extern int yylex();
extern char *yytext;
extern FILE *yyin;

void yyerror(const char *s);

%}

%union {
    int ival;
    float fval;
    char *sval;
}

%token TOKEN_PROGRAM TOKEN_MAIN TOKEN_END TOKEN_VAR TOKEN_INT TOKEN_FLOAT TOKEN_VOID
%token TOKEN_IF TOKEN_ELSE TOKEN_WHILE TOKEN_DO TOKEN_PRINT
%token <sval> TOKEN_ID
%token <ival> TOKEN_CTE_INT
%token <fval> TOKEN_CTE_FLOAT
%token <sval> TOKEN_CTE_STRING
%token TOKEN_PLUS TOKEN_MINUS TOKEN_MULT TOKEN_DIV TOKEN_GT TOKEN_LT TOKEN_NE TOKEN_ASSIGN
%token TOKEN_SEMICOLON TOKEN_COLON TOKEN_COMMA TOKEN_LBRACE TOKEN_RBRACE TOKEN_LPAREN TOKEN_RPAREN

/* Definir precedencia y asociatividad de operadores (opcional pero recomendado) */
%left TOKEN_PLUS TOKEN_MINUS
%left TOKEN_MULT TOKEN_DIV
%nonassoc TOKEN_GT TOKEN_LT TOKEN_NE /* Operadores relacionales no asociativos */

%start programa

%%

programa: TOKEN_PROGRAM TOKEN_ID TOKEN_SEMICOLON vars_opt funcs_opt TOKEN_MAIN cuerpo TOKEN_END
        ;

vars_opt: TOKEN_VAR lista_vars_decl
        | 
        ;

lista_vars_decl: declaracion
               | declaracion lista_vars_decl
               ;

declaracion: TOKEN_ID TOKEN_COLON tipo TOKEN_SEMICOLON
           ;

tipo: TOKEN_INT
    | TOKEN_FLOAT
    ;

funcs_opt: funcion funcs_opt
         | 
         ;

funcion: TOKEN_VOID TOKEN_ID TOKEN_LPAREN params_opt TOKEN_RPAREN TOKEN_LBRACE vars_opt cuerpo TOKEN_RBRACE
       ;

params_opt: parametros
          | 
          ;

parametros: TOKEN_ID TOKEN_COLON tipo
          | TOKEN_ID TOKEN_COLON tipo mas_parametros
          ;

mas_parametros: TOKEN_COMMA TOKEN_ID TOKEN_COLON tipo
              | TOKEN_COMMA TOKEN_ID TOKEN_COLON tipo mas_parametros
              ;

cuerpo: TOKEN_LBRACE lista_estatutos_opt TOKEN_RBRACE
      ;

lista_estatutos_opt: lista_estatutos
                   | 
                   ;

lista_estatutos: estatuto
               | estatuto lista_estatutos
               ;

estatuto: asignacion TOKEN_SEMICOLON
        | condicion TOKEN_SEMICOLON
        | ciclo TOKEN_SEMICOLON
        | llamada_func TOKEN_SEMICOLON
        | impresion TOKEN_SEMICOLON
        ;

asignacion: TOKEN_ID TOKEN_ASSIGN expresion
          ;

condicion: TOKEN_IF TOKEN_LPAREN expresion TOKEN_RPAREN cuerpo parte_else_opt
         ;

parte_else_opt: TOKEN_ELSE cuerpo
              | 
              ;

ciclo: TOKEN_WHILE TOKEN_LPAREN expresion TOKEN_RPAREN TOKEN_DO cuerpo
     ;

impresion: TOKEN_PRINT TOKEN_LPAREN lista_impresion TOKEN_RPAREN
         ;

lista_impresion: arg_impresion
               | arg_impresion mas_args_impresion
               ;

arg_impresion: expresion
             | TOKEN_CTE_STRING
             ;

mas_args_impresion: TOKEN_COMMA arg_impresion
                  | TOKEN_COMMA arg_impresion mas_args_impresion
                  ;

llamada_func: TOKEN_ID TOKEN_LPAREN lista_argumentos_opt TOKEN_RPAREN
            ;

lista_argumentos_opt: lista_argumentos
                    | 
                    ;

lista_argumentos: expresion
                | expresion mas_argumentos
                ;

mas_argumentos: TOKEN_COMMA expresion
              | TOKEN_COMMA expresion mas_argumentos
              ;

expresion: exp
         | exp op_relacional exp
         ;

op_relacional: TOKEN_GT
             | TOKEN_LT
             | TOKEN_NE
             ;

exp: termino
   | exp op_suma_resta termino
   ;

op_suma_resta: TOKEN_PLUS
             | TOKEN_MINUS
             ;

termino: factor
       | termino op_mult_div factor
       ;

op_mult_div: TOKEN_MULT
           | TOKEN_DIV
           ;

factor: TOKEN_LPAREN expresion TOKEN_RPAREN
      | TOKEN_ID
      | cte
      ;

cte: TOKEN_CTE_INT
   | TOKEN_CTE_FLOAT
   ;

%%

/* Función principal (ejemplo básico) */
int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 1;
        }
    } else {
        yyin = stdin;
    }

    if (yyparse() == 0) {
        printf("Analisis sintactico completado con exito.\n");
    } else {
        printf("Error en el analisis sintactico.\n");
    }

    if (yyin != stdin) {
        fclose(yyin);
    }
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error sintactico: %s cerca de '%s'\n", s, yytext);
}